class TemplatePresenter
  def initialize(template, page_template)
    @template = template
    @page_template = page_template
  end

  def truncated_template_sans_markup
    edit = TemplateSansMarkup.new unescaped_template
    edit.render(truncated_escaped_template).html_safe
  end

  def template_sans_markup
    edit = TemplateSansMarkup.new unescaped_template
    edit.render(escaped_template).html_safe
  end

private

  # We can change the delimeter so authors only need to use one
  #  bracket to enclose editable areas by changing this delimeter
  #  and editing unescaped_template to substitue double brackets
  #  like escaped_template does
  # -- Andy (@5thWall)
  DELIMITER_START = /\{\{/  # /\}/
  DELIMETER_END = /\}\}/    # /\}/

  def truncated_escaped_template
    template = @page_template.truncate @template.template, omission: "...", length: 360, seperator: ' '
    template = template.gsub DELIMITER_START, '{{{'
    template.gsub DELIMETER_END, '}}}'
  end

  def escaped_template
    template = @template.template.gsub DELIMITER_START, '{{{'
    template.gsub DELIMETER_END, '}}}'
  end

  def unescaped_template
    @template.template
  end
end

class TemplateSansMarkup < Mustache
  def initialize(template)
    words = get_words template
    words.each do |w|
      self.class.send(:define_method, w) do
        "<span class='highlight2'>#{w}</span>"
      end
    end
  end

private

  def get_words(template)
    p_toks = lambda { |tok| (tok.instance_of? Array) && (tok[0] == :mustache) }
    tokens = Mustache::Template.new(template).tokens.find_all &p_toks
    tokens.inject([]) do |m,o|
      str = o[2][2][0]
      m.include?(str) ? m : m << str
    end
  end
end
