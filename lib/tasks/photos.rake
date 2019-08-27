# frozen_string_literal: true

namespace :photos do
  desc 'Reprocess all photos'
  task reprocess: :environment do
    Photo.find_each do |photo|
      photo.update(image: photo.image[:original])
    end
  end
end
