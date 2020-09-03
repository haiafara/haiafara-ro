# frozen_string_literal: true

require 'rails_helper'

describe TrackSerializer do
  subject { JSON.parse(described_class.new(track).serialized_json) }

  let(:track) { build(:track, :three_points) }

  describe 'data' do
    let(:data) { subject['data'] }

    it 'has the correct id' do
      expect(data['id']).to eq(track.slug)
    end

    it 'has the correct type' do
      expect(data['type']).to eq('track')
    end

    describe 'attributes' do
      let(:attributes) { data['attributes'] }

      it 'has exactly 4 attributes' do
        expect(attributes.size).to eq(4)
      end

      it 'has the correct name attribute' do
        expect(attributes['name']).to eq(track.name)
      end

      it 'has the correct description attribute' do
        expect(attributes['description']).to eq(track.description)
      end

      it 'has the correct shape attribute' do
        expect(attributes['shape']).to eq(
          'type' => 'LineString',
          'coordinates' => [[23.70084, 47.662523], [23.700827, 47.662598], [23.700791, 47.662778]]
        )
      end

      it 'has the correct bounds attribute' do
        expect(attributes['bounds']).to eq([[47.662523, 23.700791], [47.662778, 23.70084]])
      end
    end
  end
end
