# frozen_string_literal: true

require 'rails_helper'

describe API::TracksController, type: :request do
  let(:track) { create(:track, :three_points) }

  describe 'GET /api/tracks/:slug' do
    before { get api_track_path(track) }

    it 'responds with 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'responds with the correct content type' do
      expect(response.media_type).to eq('application/json')
    end
  end
end
