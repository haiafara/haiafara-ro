# frozen_string_literal: true

require 'image_processing/mini_magick'

# Our friendly image uploader (used for photos)
class ImageUploader < Shrine
  plugin :determine_mime_type
  plugin :cached_attachment_data
  plugin :store_dimensions, analyzer: :mini_magick
  plugin :derivatives

  plugin :upload_options, store: lambda { |io, derivative: nil, **|
    { acl: derivative.nil? ? 'private' : 'public-read' }
  }

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      extralarge:  magick.resize_to_limit!(1920, 1920),
      large:       magick.resize_to_limit!(1200, 1200),
      medium:      magick.resize_to_limit!(600, 600),
      thumbnail:   magick.resize_to_fill!(150, 150)
    }
  end
end
