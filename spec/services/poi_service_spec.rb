# frozen_string_literal: true

require 'rails_helper'

RSpec.describe POIService do
  describe '#update_shape_from_overpass' do
    let(:poi) { create(:poi, :with_zones) }
    let(:point) { RGeo::Geographic.spherical_factory(srid: 4326).parse_wkt('POINT (1 1)') }
    context 'when there is one match' do
      before do
        allow(Underpass::QL::Query).to receive(:perform).and_return([point])
      end
      it 'updates the shape column' do
        POIService.update_shape_from_overpass(poi.id)
        expect(poi.reload.shape).to eq(point)
      end
    end
    context 'when there are no matches' do
      pending 'no matches'
    end
    context 'when there is more than one match' do
      pending 'more than one match'
    end
  end
end
