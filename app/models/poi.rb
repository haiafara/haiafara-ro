class POI < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :zones

  after_save :update_shape

  private

  def update_shape
    GetPOIShapeJob.perform_later(self.id)
  end
end
