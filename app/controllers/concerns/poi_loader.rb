# frozen_string_literal: true

module POILoader
  extend ActiveSupport::Concern

  included do
    before_action :load_poi
  end

  def load_poi
    @poi = POI.friendly.find(params[:id])
    @resource_json = POISerializer.new(
      @poi,
      include: [:photos]
    ).serialized_json
  end
end
