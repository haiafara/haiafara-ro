# frozen_string_literal: true

require 'rails_helper'

describe ZonesController, type: :request do
  let(:zone) { create(:zone) }

  describe 'GET /zone/:slug' do
    before { get zone_path(zone) }

    it 'responds with 200' do
      expect(response).to have_http_status(200)
    end

    it 'responds with the correct content type' do
      expect(response.media_type).to eq('text/html')
    end
  end
end
