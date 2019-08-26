class ZonesController < ApplicationController
  include ZoneLoader
  def show
    @page_title = 'Hartă Turistică ' + @zone.name
  end
end
