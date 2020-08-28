# frozen_string_literal: true

require 'rails_helper'

describe POIMailer, type: :mailer do
  let(:poi) { create(:poi, overpass_query: 'test') }

  describe 'no_match_notice' do
    let(:mail) { described_class.no_match_notice(poi) }

    it 'renders the correct subject field' do
      expect(mail.subject).to eq("[admin] #{poi.name} - Nu există potriviri")
    end

    it 'renders the correct to field' do
      expect(mail.to).to eq([Rails.application.credentials.mailer[:admin_email]])
    end

    it 'renders the correct from field' do
      expect(mail.from).to eq([Rails.application.credentials.mailer[:default_from]])
    end

    it 'renders the body containing the POI name' do
      expect(mail.body.encoded).to match(poi.name)
    end

    it 'renders the body containing the Overpass query' do
      expect(mail.body.encoded).to match(poi.overpass_query)
    end
  end

  describe 'many_matches_notice' do
    let(:mail) { described_class.many_matches_notice(poi) }

    it 'renders the correct subject field' do
      expect(mail.subject).to eq("[admin] #{poi.name} - Există mai mult de o potrivire")
    end

    it 'renders the correct to field' do
      expect(mail.to).to eq([Rails.application.credentials.mailer[:admin_email]])
    end

    it 'renders the correct from field' do
      expect(mail.from).to eq([Rails.application.credentials.mailer[:default_from]])
    end

    it 'renders the body containing the POI name' do
      expect(mail.body.encoded).to match(poi.name)
    end

    it 'renders the body containing the Overpass query' do
      expect(mail.body.encoded).to match(poi.overpass_query)
    end
  end
end
