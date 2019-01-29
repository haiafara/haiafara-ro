require 'rails_helper'

RSpec.describe PagesController, type: :request do
  let!(:zone) { create(:zone, default: true) }
  describe 'GET /' do
    subject { get root_path }
    it 'redirects to the default zone' do
      expect(subject).to redirect_to(zone_path(zone))
    end
  end
end
