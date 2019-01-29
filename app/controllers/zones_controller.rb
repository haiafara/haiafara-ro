class ZonesController < ApplicationController
  def show
    @zone = Zone.friendly.find(params[:id])
    @page_title = 'Hartă Turistică ' + @zone.name
  end
end
