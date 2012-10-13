class RadlibsPresenter
  def initialize(radlib, template)
    @radlib = radlib
    @words = RadlibMustache.new JSON.parse(radlib.words)
    @template = template
  end

  def filled_in_radlib
    @words.render @radlib.template.template
  end
end

class RadlibMustache < Mustache
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
      @vals[name].pop
    end
  end

  def create_numbered_method(name, value)
    self.class.send(:define_method, name) do
      value
    end
  end
end
