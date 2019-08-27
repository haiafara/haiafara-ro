require 'rails_helper'

RSpec.describe PhotoSerializer do
  let(:photo) { build(:photo, photoable: build(:poi)) }
  let(:uploaded_file_double) { double(ImageUploader::UploadedFile) }

  subject { JSON.parse(described_class.new(photo).serialized_json) }

  before do
    allow(uploaded_file_double).to receive(:url).and_return('test')
    allow_any_instance_of(Photo).to receive(:image).and_return({
      thumbnail: uploaded_file_double,
      large: uploaded_file_double
    })
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
        expect(attributes['thumbnail']).to eq('test')
      end

      it 'has the correct attribute' do
        expect(attributes['large']).to eq('test')
      end
    end
  end
end
