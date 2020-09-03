# frozen_string_literal: true

module Support
  class Utilities
    def self.wkt_to_hex_format_wkb(wkt)
      RGeo::WKRep::WKBGenerator.new(
        hex_format: true,
        type_format: :ewkb,
        emit_ewkb_srid: true
      ).generate(
        RGeo::Geographic.spherical_factory(srid: 4326).parse_wkt(wkt)
      )
    end
  end
end
