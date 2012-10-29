class StoryPresenter
  def initialize(story, radlib)
    @story = story
    @radlib = radlib
  end

  def filled_in_story
    words = StoryDisplay.new words_data
    words.render unescaped_radlib
  end

  def editable_story
    edit = StoryEdit.new unescaped_radlib
    edit.render(escaped_radlib).html_safe
  end

private

  # We can change the delimeter so authors only need to use one
  #  bracket to enclose editable areas by changing this delimeter
  #  and editing unescaped_radlib to substitue double brackets
  #  like escaped_radlib does
  # -- Andy (@5thWall)
  DELIMITER_START = /\{\{/  # /\}/
  DELIMETER_END = /\}\}/    # /\}/

  def escaped_radlib
    radlib = sanitized_radlib.gsub DELIMITER_START, '{{{'
    radlib.gsub DELIMETER_END, '}}}'
  end

  def unescaped_radlib
    sanitized_radlib
  end

  def sanitized_radlib
    radlib = @story.template
    radlib = radlib.gsub /\{\{\{/, '{{'
    radlib = radlib.gsub /\}\}\}/, '}}'
    radlib = radlib.gsub /\{\{(.*?)\}\}/ do |match|
      str = $1.split(' ').join('_')
      "{{#{str}}}"
    end
    radlib = radlib.gsub /\{\{[\#\/\^\=]/, '{{'
    radlib.gsub /\=\}\}/, '}}'
  end

  def words_data
    begin
      JSON.parse @story.words
    rescue
      { "Adjective" => ["pretty", "stupid", "ugly", "bitchin'", "shiny", "user-centric", "subtle", "default"],
        "adjective" => ["pretty", "stupid", "ugly", "bitchin'", "shiny", "user-centric", "subtle", "default"],
        "Verb" => ["share", "kill", "run", "code"],
        "verb" => ["share", "kill", "run", "code"],
        "Noun" => ["Princess", "dog", "friends", "code", "Internet"],
        "noun" => ["pony", "unicorn", "Rails Rumble 2012"]
      }
    end
  end
end

class StoryDisplay < Mustache
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

class StoryEdit < Mustache
  def initialize(radlib)
    words = get_words radlib
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

  def get_words(radlib)
    p_toks = lambda { |tok| (tok.instance_of? Array) && (tok[0] == :mustache) }
    tokens = Mustache::Template.new(radlib).tokens.find_all &p_toks
    tokens.inject([]) do |m,o|
      str = o[2][2][0]
      m.include?(str) ? m : m << str
    end
  end
end
