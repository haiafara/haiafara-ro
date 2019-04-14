class POISerializer
  include FastJsonapi::ObjectSerializer
  set_id :slug
  attributes :name, :description
  attribute :shape do |object|
    RGeo::GeoJSON.encode(object.shape)
  end
end
