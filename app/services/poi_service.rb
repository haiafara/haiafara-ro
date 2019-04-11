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
          # send not found email
        else
          # send more than one found email
        end
      end
    end
  end
end
