# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageUploader do
  subject { described_class.new(:store) }

  describe 'upload_options plugin' do
    let(:store_lambda) { subject.opts[:upload_options][:store] }

    context 'for original version' do
      let(:acl) { store_lambda.call(double, version: :original)[:acl] }

      it 'returns private acl' do
        expect(acl).to eq('private')
      end
    end

    context 'for other versions' do
      let(:acl) { store_lambda.call(double, version: :other)[:acl] }

      it 'returns public-read acl' do
        expect(acl).to eq('public-read')
      end
    end
  end
end
