class POI < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :zones

  scope :recommended, -> { where(recommended: true) }

  after_save :enqueue_update_shape_job

  private

  def enqueue_update_shape_job
    POIUpdateShapeJob.perform_later(self.id)
  end
end
