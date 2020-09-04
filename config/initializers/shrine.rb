# frozen_string_literal: true

require 'shrine'

if Rails.env.test?
  require 'shrine/storage/memory'

  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
else
  require 'shrine/storage/s3'

  s3_options = {
    access_key_id: ENV['S3_ACCESS_KEY_ID'],
    secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
    region: ENV['S3_REGION'],
    bucket: ENV['S3_BUCKET']
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
    store: Shrine::Storage::S3.new(prefix: 'store', **s3_options)
  }
end

Shrine.plugin :activerecord

Shrine.plugin :backgrounding

Shrine::Attacher.promote_block do
  PromoteJob.perform_later(
    self.class.name,
    record.class.name,
    record.id,
    name,
    file_data
  )
end

Shrine::Attacher.destroy_block do
  DestroyJob.perform_later(self.class.name, data)
end
