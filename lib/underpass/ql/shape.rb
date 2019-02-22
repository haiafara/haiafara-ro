# frozen_string_literal: true

module Underpass
  module QL
    # Contains factories for various shapes from ways and nodes.
    class Shape
      def self.polygon_from_way(way, nodes)
        f = RGeo::Geographic.spherical_factory(srid: 4326)
        f.polygon(line_string_from_way(way, nodes))
      end

      def self.line_string_from_way(way, nodes)
        f = RGeo::Geographic.spherical_factory(srid: 4326)
        f.line_string(
          way[:nodes].map do |n|
            f.point(nodes[n][:lon], nodes[n][:lat])
          end
        )
      end

      # There should be some sort of 'decorator' to return an object
      # with the shape and a copy of the tags as
      # {
      #   tags: way[:tags],
      #   shape: shape
      # }
    end
  end
end
