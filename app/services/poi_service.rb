# frozen_string_literal: true

module POIService
  class << self
    def update_shape_from_overpass(id)
      poi = POI.find(id)
      poi.zones.with_expanded_bounding_box.each do |z|
        matches = Underpass::QL::Query.perform(
          z.expanded_bounding_box,
          poi.overpass_query
        )
        case matches.size
        when 1
          poi.update_column(:shape, matches.first)
          break
        when 0
          POIMailer.no_match_notice(poi).deliver_now
        else
          POIMailer.many_matches_notice(poi).deliver_now
        end
      end
    end
  end
end
