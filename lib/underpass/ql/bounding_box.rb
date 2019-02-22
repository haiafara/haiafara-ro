# frozen_string_literal: true

module Underpass
  module QL
    # Bounding box related utilities.
    class BoundingBox
      # returns the Overpass query language bounding box string
      # when provided with an RGeo geometry
      def self.from_geometry(geometry)
        r_bb = RGeo::Cartesian::BoundingBox.create_from_geometry(geometry)
        "bbox:#{r_bb.min_y},#{r_bb.min_x},#{r_bb.max_y},#{r_bb.max_x}"
      end
    end
  end
end
