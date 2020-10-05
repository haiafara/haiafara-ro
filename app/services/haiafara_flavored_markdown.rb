# frozen_string_literal: true

# Yummy Markdown
class HaiafaraFlavoredMarkdown < Redcarpet::Render::HTML
  def preprocess(text)
    text = link_zones(text)
    text = link_pois(text)
    text = link_photos(text)
    text
  end

  def link_zones(text)
    text.gsub(/\(unde\=\'(.+?)\'\)/, '(/unde/\1)')
  end

  def link_pois(text)
    text.gsub(/\(pdi\=\'(.+?)\'\)/, '(/pdi/\1)')
  end

  def link_photos(text)
    text.gsub(/\(foto\=\'(.+?)\'\)/, '(/foto/\1)')
  end
end
