# frozen_string_literal: true

module Underpass
  module QL
    # Convenience class, provides the perform static method.
    class Query
      def self.perform(bounding_box, query)
        op_bbox = Underpass::QL::BoundingBox.from_geometry(bounding_box)
        response = Underpass::QL::Request.new(query, op_bbox).run
        Underpass::QL::Parser.new(response).parse.matches
      end
    end
  end
end
