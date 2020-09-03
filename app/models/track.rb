# frozen_string_literal: true

# tracks are the lifeblood of haiafara
# these are the hikes, the runs, the rides
class Track < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :photos, as: :photoable
  has_and_belongs_to_many :zones

  scope :recommended, -> { where(recommended: true) }
end
