# frozen_string_literal: true

# POIsController takes care of displaying POIs
class POIsController < ApplicationController
  include POILoader

  def show
    @page_title = @poi.name
  end
end
