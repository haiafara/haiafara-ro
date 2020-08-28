# frozen_string_literal: true

require 'rails_helper'

describe ImageUploader do
  subject { described_class.new(:store) }

  describe 'upload_options plugin' do
    let(:store_lambda) { subject.opts[:upload_options][:store] }

    context 'when original version' do
      let(:acl) { store_lambda.call(double, derivative: nil)[:acl] }

      it 'returns private acl' do
        expect(acl).to eq('private')
      end
    end

    context 'when other versions' do
      let(:acl) { store_lambda.call(double, derivative: :other)[:acl] }

      it 'returns public-read acl' do
        expect(acl).to eq('public-read')
      end
    end
  end
end
