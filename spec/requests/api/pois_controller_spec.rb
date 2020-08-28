# frozen_string_literal: true

require 'rails_helper'

describe API::POIsController, type: :request do
  let(:poi) { create(:poi, :point) }

  describe 'GET /api/poi/:slug' do
    before { get api_poi_path(poi) }

    it 'responds with 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'responds with the correct content type' do
      expect(response.media_type).to eq('application/json')
    end
  end
end
