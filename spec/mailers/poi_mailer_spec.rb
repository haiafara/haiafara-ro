require "rails_helper"

RSpec.describe POIMailer, type: :mailer do
  let(:poi) { create(:poi, overpass_query: 'test') }

  describe "no_match_notice" do
    let(:mail) { POIMailer.no_match_notice(poi) }

    it "renders the headers" do
      expect(mail.subject).to eq("[admin] #{poi.name} - Nu există potriviri")
      expect(mail.to).to eq(['haiafara.ro@gmail.com'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(poi.name)
      expect(mail.body.encoded).to match(poi.overpass_query)
    end
  end

  describe "many_matches_notice" do
    let(:mail) { POIMailer.many_matches_notice(poi) }

    it "renders the headers" do
      expect(mail.subject).to eq("[admin] #{poi.name} - Există mai mult de o potrivire")
      expect(mail.to).to eq(['haiafara.ro@gmail.com'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(poi.name)
      expect(mail.body.encoded).to match(poi.overpass_query)
    end
  end
end
