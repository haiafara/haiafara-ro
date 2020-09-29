# frozen_string_literal: true

# Point Of Interest
class POI < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :photos, as: :photoable
  has_and_belongs_to_many :zones

  scope :recommended, -> { where(recommended: true) }

  before_save :set_description_html
  after_save :enqueue_update_shape_job

  private

  def set_description_html
    markdown = Redcarpet::Markdown.new(HaiafaraFlavoredMarkdown)
    self.description_html = markdown.render(description.to_s.html_safe)
  end

  def enqueue_update_shape_job
    POIUpdateShapeJob.perform_later(id)
  end
end
