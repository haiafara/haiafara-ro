# frozen_string_literal: true

class API::ZonesController < ApplicationController
  include ZoneLoader
  def show
    render json: @resource_json
  end
end
