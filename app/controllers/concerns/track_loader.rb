# frozen_string_literal: true

# takes care of loading a track
module TrackLoader
  extend ActiveSupport::Concern

  included do
    before_action :load_track
  end

  def load_track
    @track = Track.friendly.find(params[:id])
    @resource_json = TrackSerializer.new(
      @track,
      include: [:photos]
    ).serialized_json
  end
end
