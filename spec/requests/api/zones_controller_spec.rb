require 'rails_helper'

RSpec.describe API::ZonesController, type: :request do
  let(:zone) { create(:zone) }

  describe "GET /api/zone/:slug" do
    before(:each) { get api_zone_path(zone) }

    it "responds with 200" do
      expect(response).to have_http_status(200)
    end

    it "responds with the correct content type" do
      expect(response.media_type).to eq('application/json')
    end
  end
end
