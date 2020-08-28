# frozen_string_literal: true

require 'rails_helper'

describe POIUpdateShapeJob, type: :job do
  describe '#perform_later' do
    it 'enqueues the job' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        described_class.perform_later(1)
      end.to have_enqueued_job
    end

    it 'calls the correct service method' do
      allow(POIService).to receive(:update_shape_from_overpass)
      described_class.perform_now(1)
      expect(POIService).to have_received(:update_shape_from_overpass).with(1)
    end
  end
end
