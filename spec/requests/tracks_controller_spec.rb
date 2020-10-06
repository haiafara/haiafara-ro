# frozen_string_literal: true

require 'rails_helper'

describe TracksController, type: :request do
  let(:track) { create(:track, :three_points) }

  describe 'GET /traseu/:slug' do
    before { get track_path(track) }

    it 'responds with 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'responds with the correct content type' do
      expect(response.media_type).to eq('text/html')
    end
  end
end
