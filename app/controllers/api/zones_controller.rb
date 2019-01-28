class API::ZonesController < ApplicationController
  def show
    @zone = Zone.friendly.find(params[:id])
    render json: ZoneSerializer.new(@zone).serialized_json
  end
end
