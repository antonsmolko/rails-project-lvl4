# frozen_string_literal: true

# HexletCode module
module HexletCode
  # FormTemplate class - html form render
  class FormTemplate
    def initialize(inputs, url, method = 'post')
      @inputs = inputs
      @method = method
      @url = url
    end

    def build(action, method, inner)
      Tag.build('form', action: action, method: method) { %(\n#{inner}\n) }
    end

    def build_group(attrs)
      name = attrs.delete(:name)
      type = attrs.delete(:as) || :string

      input_klass = "#{type.to_s.capitalize}Input"
      klass = Object.const_get "HexletCode::Inputs::#{input_klass}"

      group = []
      group << Label.build(name) unless %w[submit reset hidden button].include?(attrs[:type])
      group << klass.new(name, **attrs).build
      group.join("\n")
    end

    def render
      inner = @inputs.map { |attrs| build_group(attrs) }.join("\n")
      build(@url, @method, inner)
    end
  end
end
