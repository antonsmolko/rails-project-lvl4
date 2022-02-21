# frozen_string_literal: true

require_relative 'base'

# HexletCode module
module HexletCode
  module Inputs
    # Textarea class returns html textarea
    class TextInput < Base
      def build
        attrs_h = { cols: 20, rows: 40, name: @name, **@attrs }

        HexletCode::Tag.build('textarea', **attrs_h) { @value }
      end
    end
  end
end
