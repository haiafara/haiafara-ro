class Zone < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :region
  has_and_belongs_to_many :pois
end
