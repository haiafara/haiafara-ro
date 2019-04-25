class POIMailer < ApplicationMailer
  def no_match_notice(poi)
    @poi = poi
    mail to: Rails.application.credentials.mailer[:admin_email],
         subject: t('.subject', poi_name: poi.name)
  end

  def many_matches_notice(poi)
    @poi = poi
    mail to: Rails.application.credentials.mailer[:admin_email],
         subject: t('.subject', poi_name: poi.name)
  end
end
