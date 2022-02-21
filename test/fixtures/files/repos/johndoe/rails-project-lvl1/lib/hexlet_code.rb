# frozen_string_literal: true

require_relative 'hexlet_code/version'

# HexletCode module
module HexletCode
  autoload :FormGenerator, 'hexlet_code/form_generator'
  autoload :FormTemplate, 'hexlet_code/form_template'
  autoload :Inputs, 'hexlet_code/inputs'
  autoload :Tag, 'hexlet_code/tag'
  autoload :Label, 'hexlet_code/label'

  def self.form_for(entity, url: nil)
    form_generator = FormGenerator.new(entity.to_h)

    yield form_generator

    form_template = FormTemplate.new(form_generator.inputs, url)
    form_template.render
  end
end
