require 'rails_helper'

RSpec.describe ZoneSerializer do
  let(:zone) { build(:zone) }

  subject { JSON.parse(described_class.new(zone).serialized_json) }

  describe 'data' do
    let(:data) { subject['data'] }

    it 'has the correct id' do
      expect(data['id']).to eq(zone.slug)
    end

    it 'has the correct type' do
      expect(data['type']).to eq('zone')
    end

    describe 'attributes' do
      let(:attributes) { data['attributes'] }

      it 'has exactly 3 attributes' do
        expect(attributes.size).to eq(3)
      end

      it 'has the correct name attribute' do
        expect(attributes['name']).to eq(zone.name)
      end

      it 'has the correct description attribute' do
        expect(attributes['description']).to eq(zone.description)
      end

      it 'has the correct bounds attribute' do
        expect(attributes['bounds']).to eq([[47.65, 23.669], [47.674, 23.725]])
      end
    end
  end
end
