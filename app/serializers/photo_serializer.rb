# frozen_string_literal: true

class PhotoSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  attributes :name, :description_html
  attribute :thumbnail do |object|
    object.image_url(:thumbnail)
  end
  attribute :large do |object|
    object.image_url(:large)
  end
end
