# frozen_string_literal: true

require 'image_processing/mini_magick'

# Our friendly image uploader (used for photos)
class ImageUploader < Shrine
  plugin :determine_mime_type
  plugin :processing
  plugin :versions
  plugin :cached_attachment_data

  plugin :upload_options, store: lambda { |_io, context|
    { acl: context[:version] == :original ? 'private' : 'public-read' }
  }

  process(:store) do |io, _context|
    versions = { original: io }
    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)
      versions[:large] = pipeline.resize_to_limit!(1920, 1920)
      versions[:medium] = pipeline.resize_to_limit!(600, 600)
      versions[:thumbnail] = pipeline.resize_to_fill!(100, 100)
    end
    versions
  end
end
