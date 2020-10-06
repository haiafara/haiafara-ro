# frozen_string_literal: true

# Zones are windows to the world on haiafara.
# You start exploring from a zone.
class Zone < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :region
  has_many :photos, as: :photoable
  has_and_belongs_to_many :pois, class_name: 'POI'
  has_and_belongs_to_many :tracks

  scope :with_expanded_bounding_box, lambda {
    query = <<-SQL.squish
      ST_Expand(
        bounding_box::geometry,
        (ST_XMax(bounding_box::geometry) - ST_XMin(bounding_box::geometry)) * 2,
        (ST_YMax(bounding_box::geometry) - ST_YMin(bounding_box::geometry)) * 2
      )::geography AS expanded_bounding_box
    SQL
    select('*').select(query)
  }

  before_save :set_description_html

  private

  def set_description_html
    markdown = Redcarpet::Markdown.new(HaiafaraFlavoredMarkdown)
    self.description_html = markdown.render(description.to_s.html_safe)
  end
end
