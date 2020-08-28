# frozen_string_literal: true

require 'rails_helper'

describe PagesController, type: :request do
  describe 'GET /' do
    subject(:root_path_request) { get root_path }

    context 'when a default zone exists' do
      let!(:zone) { create(:zone, default: true) }

      it 'redirects to the default zone' do
        expect(root_path_request).to redirect_to(zone_path(zone))
      end
    end

    context 'when a zone exists but it is not default' do
      before { create(:zone) }

      it 'redirects to the no zone page' do
        expect(root_path_request).to redirect_to(pages_no_zone_path)
      end
    end

    context 'when no zones were created' do
      it 'redirects to the no zone page' do
        expect(root_path_request).to redirect_to(pages_no_zone_path)
      end
    end
  end

  describe 'GET /pages/no_zone' do
    before { get pages_no_zone_path }

    it 'responds with 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'responds with the correct content type' do
      expect(response.media_type).to eq('text/plain')
    end
  end
end
