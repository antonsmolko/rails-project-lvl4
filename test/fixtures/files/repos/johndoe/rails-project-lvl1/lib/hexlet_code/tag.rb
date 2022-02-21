# frozen_string_literal: true

module HexletCode
  # Tag module returns html string for tag
  module Tag
    def self.build(tag_name, attributes = {})
      attrs_s = attributes.compact.map do |key, value|
        value == true ? key : %(#{key}="#{value}")
      end.join(' ')

      single_tags = %w[area base br col command embed hr img input keygen link meta param source track wbr]

      if single_tags.include?(tag_name)
        "<#{tag_name} #{attrs_s}/>"
      else
        "<#{tag_name} #{attrs_s}>#{yield}</#{tag_name}>"
      end
    end
  end
end
