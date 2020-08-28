# frozen_string_literal: true

require 'rails_helper'

describe POIService do
  describe '#update_shape_from_overpass' do
    let(:poi) { create(:poi, :with_zones) }
    let(:point) { RGeo::Geographic.spherical_factory(srid: 4326).parse_wkt('POINT (1 1)') }

    context 'when there are no matches' do
      let(:deliveries) { ActionMailer::Base.deliveries }

      before do
        allow(Underpass::QL::Query).to receive(:perform)
          .and_return([])
        ActiveJob::Base.queue_adapter = :test
      end

      it 'sends one email' do
        expect do
          described_class.update_shape_from_overpass(poi.id)
        end.to change(deliveries, :count).by(1)
      end

      it 'sends an email with the correct subject' do
        described_class.update_shape_from_overpass(poi.id)
        expect(deliveries.last.subject).to eq(
          I18n.t('poi_mailer.no_match_notice.subject', poi_name: poi.name)
        )
      end
    end

    context 'when there is one match' do
      before do
        allow(Underpass::QL::Query).to receive(:perform).and_return([point])
      end

      it 'updates the shape column' do
        described_class.update_shape_from_overpass(poi.id)
        expect(poi.reload.shape).to eq(point)
      end
    end

    context 'when there is more than one match' do
      let(:deliveries) { ActionMailer::Base.deliveries }

      before do
        allow(Underpass::QL::Query).to receive(:perform)
          .and_return([point, point])
        ActiveJob::Base.queue_adapter = :test
      end

      it 'sends one email' do
        expect do
          described_class.update_shape_from_overpass(poi.id)
        end.to change(deliveries, :count).by(1)
      end

      it 'sends an email with the correct subject' do
        described_class.update_shape_from_overpass(poi.id)
        expect(deliveries.last.subject).to eq(
          I18n.t('poi_mailer.many_matches_notice.subject', poi_name: poi.name)
        )
      end
    end
  end
end
