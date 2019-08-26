class API::POIsController < ApplicationController
  include POILoader
  def show
    render json: @resource_json
  end
end
