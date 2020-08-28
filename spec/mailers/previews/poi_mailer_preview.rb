# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/poi_mailer
class POIMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/poi_mailer/no_match_notice
  def no_match_notice
    poi = POI.new(name: 'Test', overpass_query: 'Test Query')
    POIMailer.no_match_notice(poi)
  end

  # Preview this email at http://localhost:3000/rails/mailers/poi_mailer/many_matches_notice
  def many_matches_notice
    poi = POI.new(name: 'Test', overpass_query: 'Test Query')
    POIMailer.many_matches_notice(poi)
  end
end
