class Zone < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :region
end
