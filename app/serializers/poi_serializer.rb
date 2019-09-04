# frozen_string_literal: true

class POISerializer
  include FastJsonapi::ObjectSerializer
  set_id :slug
  attributes :name, :description
  attribute :shape do |object|
    RGeo::GeoJSON.encode(object.shape)
  end
  attribute :bounds do |object|
    bb = RGeo::Cartesian::BoundingBox.create_from_geometry(object.shape)
    # now, why wouldn't it be reversed
    [[bb.min_y, bb.min_x], [bb.max_y, bb.max_x]]
  end
  has_many :photos
end
