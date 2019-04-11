class POIMailer < ApplicationMailer
  def no_match_notice(poi)
    @poi = poi
    mail to: 'haiafara.ro@gmail.com', subject: t('.subject', poi_name: poi.name)
  end

  def many_matches_notice(poi)
    @poi = poi
    mail to: 'haiafara.ro@gmail.com', subject: t('.subject', poi_name: poi.name)
  end
end
