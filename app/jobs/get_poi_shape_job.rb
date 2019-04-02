class GetPOIShapeJob < ApplicationJob
  queue_as :default

  def perform(poi_id)
    POIService.update_shape_from_overpass(poi_id)
  end
end
