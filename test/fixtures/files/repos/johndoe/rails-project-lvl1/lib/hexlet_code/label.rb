# frozen_string_literal: true

# HexletCode module
module HexletCode
  # Label class returns html label
  class Label
    def self.build(name)
      Tag.build('label', for: name) { name.capitalize }
    end
  end
end
