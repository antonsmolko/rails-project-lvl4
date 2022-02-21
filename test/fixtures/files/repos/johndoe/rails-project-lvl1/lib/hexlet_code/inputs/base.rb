# frozen_string_literal: true

# HexletCode module
module HexletCode
  module Inputs
    # BaseInput class
    class Base
      attr_accessor :name, :type, :value, :as, :attrs

      def initialize(name, value: nil, type: 'text', **attrs)
        @name = name
        @type = type
        @value = value
        @as = attrs.delete(:as)
        @attrs = attrs
      end

      def build
        attrs_h = { type: @type, name: @name, **@attrs }
        attrs_h[:value] = @value if @value

        HexletCode::Tag.build('input', **attrs_h)
      end
    end
  end
end
