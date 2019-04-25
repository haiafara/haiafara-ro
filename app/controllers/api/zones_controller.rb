class API::ZonesController < ApplicationController
  def show
    @zone = Zone.includes(:pois).friendly.find(params[:id])
    render json: ZoneSerializer.new(
      @zone,
      include: [:pois]
    ).serialized_json
  end
end
