# frozen_string_literal: true

require 'rails_helper'

describe PromoteJob, type: :job do
  describe '#perform' do
    let(:attacher) { double }
    let(:record) { double }
    let(:record_id) { 'test' }
    let(:name) { 'test' }
    let(:file_data) { 'test' }

    before do
      ActiveJob::Base.queue_adapter = :test

      stub_const('AttacherClassStub', ImageUploader::Attacher)
      stub_const('RecordClassStub', Photo)

      allow(AttacherClassStub).to receive(:retrieve).and_return(attacher)
      allow(RecordClassStub).to receive(:find).and_return(record)
      allow(attacher).to receive(:create_derivatives)
      allow(attacher).to receive(:atomic_promote)

      described_class.perform_now('AttacherClassStub', 'RecordClassStub', record_id, name, file_data)
    end

    it 'calls retrieve on the attacher class' do
      expect(AttacherClassStub).to have_received(:retrieve).with(
        model: record,
        name: name,
        file: file_data
      )
    end

    it 'calls create_derivatives on the attacher' do
      expect(attacher).to have_received(:create_derivatives)
    end

    it 'calls atomic_promote on the attacher' do
      expect(attacher).to have_received(:atomic_promote)
    end
  end
end
