# frozen_string_literal: true

require_relative 'utilities'

module Support
  class LineStrings
    ThreePoints = Support::Utilities.wkt_to_hex_format_wkb(
      'LINESTRING (23.70084 47.662523, 23.700827 47.662598, 23.700791 47.662778)'
    )
  end
end
