require 'rails_helper'

RSpec.describe ZonesController, type: :request do
  let(:zone) { create(:zone) }
  describe 'GET /zone/:slug' do
    before(:each) { get zone_path(zone) }
    it 'responds with 200' do
      expect(response).to have_http_status(200)
    end

    it 'responds with the correct content type' do
      expect(response.content_type).to eq('text/html')
    end
  end
end
