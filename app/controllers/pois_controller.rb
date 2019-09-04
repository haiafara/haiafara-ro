# frozen_string_literal: true

class POIsController < ApplicationController
  include POILoader
  def show
    @page_title = @poi.name
  end
end
