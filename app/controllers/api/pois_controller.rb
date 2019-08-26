class API::POIsController < ApplicationController
  def show
    @poi = POI.friendly.find(params[:id])
    render json: POISerializer.new(
      @poi,
      include: [:photos]
    ).serialized_json
  end
end
