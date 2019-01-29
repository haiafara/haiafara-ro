class ZoneSerializer
  include FastJsonapi::ObjectSerializer
  set_id :slug
  attributes :name, :description
  attribute :bounds do |object|
    bb = RGeo::Cartesian::BoundingBox.create_from_geometry(object.bounding_box)
    # now, why wouldn't it be reversed
    [[bb.min_y, bb.min_x], [bb.max_y, bb.max_x]]
  end
end
