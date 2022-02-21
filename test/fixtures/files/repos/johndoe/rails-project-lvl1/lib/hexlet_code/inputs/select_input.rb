# frozen_string_literal: true

require_relative 'base'

# HexletCode module
module HexletCode
  module Inputs
    # Select class returns html select
    class SelectInput < Base
      def build
        collection = @attrs.delete(:collection) || []
        attrs_h = { name: @name, **@attrs }
        is_multiple = @attrs.key?(:multiple) && @attrs[:multiple] == true

        options = collection.map do |option|
          option_attrs = { value: option }
          option_attrs[:selected] = true if is_multiple ? @value.include?(option) : option == @value
          option_tag = HexletCode::Tag.build('option', **option_attrs) { option }
          %(\n#{option_tag})
        end.join

        HexletCode::Tag.build('select', **attrs_h) { %(#{options}\n) }
      end
    end
  end
end
