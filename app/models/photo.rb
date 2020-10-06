# frozen_string_literal: true

class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :photoable, polymorphic: true

  before_save :set_description_html

  private

  def set_description_html
    markdown = Redcarpet::Markdown.new(HaiafaraFlavoredMarkdown)
    self.description_html = markdown.render(description.to_s.html_safe)
  end
end
