# frozen_string_literal: true

# delivers tracks in JSON
class API::TracksController < ApplicationController
  include TrackLoader
  def show
    render json: @resource_json
  end
end
