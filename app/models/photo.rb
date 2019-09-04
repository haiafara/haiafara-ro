# frozen_string_literal: true

class Photo < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :photoable, polymorphic: true
end
