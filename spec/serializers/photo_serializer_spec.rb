require 'rails_helper'

RSpec.describe PhotoSerializer do
  subject { JSON.parse(described_class.new(photo).serialized_json) }

  let(:thumbnail_image_url) { Faker::Internet.url }
  let(:large_image_url) { Faker::Internet.url }
  let(:photo) { build(:photo, photoable: build(:poi)) }

  before do
    allow(Photo).to receive(:new).and_return(photo)
    allow(photo).to receive(:image_url)
      .with(:thumbnail)
      .and_return(thumbnail_image_url)
    allow(photo).to receive(:image_url)
      .with(:large)
      .and_return(large_image_url)
  end

  describe 'data' do
    let(:data) { subject['data'] }

    it 'has the correct id' do
      photo.save
      expect(data['id']).to eq(photo.reload.id.to_s)
    end

    it 'has the correct type' do
      expect(data['type']).to eq('photo')
    end

    describe 'attributes' do
      let(:attributes) { data['attributes'] }

      it 'has exactly 4 attributes' do
        expect(attributes.size).to eq(4)
      end

      it 'has the correct name attribute' do
        expect(attributes['name']).to eq(photo.name)
      end

      it 'has the correct description attribute' do
        expect(attributes['description']).to eq(photo.description)
      end

      it 'has the correct thumbnail attribute' do
        expect(attributes['thumbnail']).to eq(thumbnail_image_url)
      end

      it 'has the correct large attribute' do
        expect(attributes['large']).to eq(large_image_url)
      end
    end
  end
end
