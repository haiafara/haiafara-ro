require 'rails_helper'

RSpec.describe API::POIsController, type: :request do
  let(:poi) { create(:poi, :point) }

  describe 'GET /api/poi/:slug' do
    before(:each) { get api_poi_path(poi) }

    it 'responds with 200' do
      expect(response).to have_http_status(200)
    end

    it 'responds with the correct content type' do
      expect(response.content_type).to eq('application/json')
    end
  end
end
