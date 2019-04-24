class ZonesController < ApplicationController
  def show
    @zone = Zone.includes(:pois).friendly.find(params[:id])
    @page_title = 'Hartă Turistică ' + @zone.name
    @resource_json = ZoneSerializer.new(
      @zone,
      include: [:pois]
    ).serialized_json
  end
end
