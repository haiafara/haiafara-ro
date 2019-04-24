require 'rails_helper'

RSpec.describe POISerializer do
  let(:poi) { build(:poi, :point) }

  subject { JSON.parse(described_class.new(poi).serialized_json) }

  describe 'data' do
    let(:data) { subject['data'] }

    it 'has the correct id' do
      expect(data['id']).to eq(poi.slug)
    end

    it 'has the correct type' do
      expect(data['type']).to eq('poi')
    end

    describe 'attributes' do
      let(:attributes) { data['attributes'] }

      it 'has exactly 4 attributes' do
        expect(attributes.size).to eq(4)
      end

      it 'has the correct name attribute' do
        expect(attributes['name']).to eq(poi.name)
      end

      it 'has the correct description attribute' do
        expect(attributes['description']).to eq(poi.description)
      end

      it 'has the correct shape attribute' do
        expect(attributes['shape']).to eq(
          'type' => 'Point',
          'coordinates' => [23.70015, 47.67137]
        )
      end

      it 'has the correct bounds attribute' do
        expect(attributes['bounds']).to eq([[47.67137, 23.70015], [47.67137, 23.70015]])
      end
    end
  end
end
