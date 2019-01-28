require 'rails_helper'

RSpec.describe ZoneSerializer do
  let(:zone) do
    Zone.new(
      name: 'Test Zone',
      slug: 'test-zone',
      bounding_box: '0103000020E610000001000000050000002506819543AB37403333333333D347409A99999999B937403333333333D347409A99999999B9374083C0CAA145D647402506819543AB374083C0CAA145D647402506819543AB37403333333333D34740'
    )
  end

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

      it 'has 2 attributes' do
        expect(attributes.size).to eq(2)
      end

      it 'has the correct name attribute' do
        expect(attributes['name']).to eq(zone.name)
      end

      it 'has the correct bounds attribute' do
        expect(attributes['bounds']).to eq([[47.65, 23.669], [47.674, 23.725]])
      end
    end
  end
end
