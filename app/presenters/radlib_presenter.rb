class RadlibPresenter
  def initialize(radlib, template)
    @radlib = radlib
    @template = template
  end

  def filled_in_radlib
    words = RadlibDisplay.new JSON.parse(@radlib.words)
    words.render unescaped_template
  end

  def editable_radlib
    edit = RadlibEdit.new unescaped_template
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

  def escaped_template
    template = @radlib.template.template.gsub DELIMITER_START, '{{{'
    template.gsub DELIMETER_END, '}}}'
  end

  def unescaped_template
    @radlib.template.template
  end
end

class RadlibDisplay < Mustache
  def initialize(data)
    data.each do |k, v|
      if v.is_a?(Array)
        create_generic_method k, v
      else
        create_numbered_method k, v
      end
    end
  end

private

  def create_generic_method(name, value)
    @vals ||= {}
    @vals[name] = value

    self.class.send(:define_method, name) do
      @vals[name].shift
    end
  end

  def create_numbered_method(name, value)
    self.class.send(:define_method, name) do
      value
    end
  end
end

class RadlibEdit < Mustache
  def initialize(template)
    words = get_words template
    words.each do |w|
      if /\d$/ =~ w
        create_numbered_method w
      else
        create_generic_method w
      end
    end
  end

private

  def create_numbered_method(name)
    self.class.send(:define_method, name) do
      "<span class='highlight' data-key='#{name}' data-type='single' contenteditable='true' onclick=\"document.execCommand('selectAll',false,null)\">#{name}</span>"
    end
  end

  def create_generic_method(name)
    self.class.send(:define_method, name) do
      @nums ||= Hash.new(-1)
      num = @nums[name] += 1
      "<span class='highlight' data-key='#{name}' data-type='array' data-index='#{num}' contenteditable='true' onclick=\"document.execCommand('selectAll',false,null)\">#{name}</span>"
    end
  end

  def get_words(template)
    p_toks = lambda { |tok| (tok.instance_of? Array) && (tok[0] == :mustache) }
    tokens = Mustache::Template.new(template).tokens.find_all &p_toks
    tokens.inject([]) do |m,o|
      str = o[2][2][0]
      m.include?(str) ? m : m << str
    end
  end
end
