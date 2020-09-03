# frozen_string_literal: true

# TracksController takes care of displaying tracks
class TracksController < ApplicationController
  include TrackLoader

  def show
    @page_title = @track.name
  end
end
