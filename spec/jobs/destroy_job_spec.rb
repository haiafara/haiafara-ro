# frozen_string_literal: true

require 'rails_helper'

describe DestroyJob, type: :job do
  describe '#perform' do
    let(:attacher) { double }
    let(:data) { 'test' }

    before do
      ActiveJob::Base.queue_adapter = :test

      stub_const('AttacherClassStub', ImageUploader::Attacher)

      allow(AttacherClassStub).to receive(:from_data).and_return(attacher)
      allow(attacher).to receive(:destroy)

      described_class.perform_now('AttacherClassStub', data)
    end

    it 'calls from_data on the attacher class' do
      expect(AttacherClassStub).to have_received(:from_data).with(data)
    end

    it 'calls destroy on the attacher' do
      expect(attacher).to have_received(:destroy)
    end
  end
end
