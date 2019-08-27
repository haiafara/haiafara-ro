class PhotoSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  attributes :name, :description
  attribute :thumbnail do |object|
    object.image[:thumbnail].url
  end
  attribute :large do |object|
    object.image[:large].url
  end
end
