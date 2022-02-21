# frozen_string_literal: true

# HexletCode module
module HexletCode
  # FormGenerator class - build inputs collections
  class FormGenerator
    attr_reader :inputs

    def initialize(entity)
      @entity = entity
      @inputs = []
    end

    def input(name, **attrs)
      return unless @entity.key?(name)

      inputs << { name: name, value: @entity[name], **attrs }
    end

    def submit(value = 'Save')
      inputs << { name: 'commit', value: value, type: 'submit' }
    end
  end
end
