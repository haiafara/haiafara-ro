# frozen_string_literal: true

require 'rails_helper'

RSpec.describe POIUpdateShapeJob, type: :job do
  describe '#perform_later' do
    it 'enqueues the job' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        POIUpdateShapeJob.perform_later(1)
      }.to have_enqueued_job
    end

    it 'calls the correct service method' do
      expect(POIService).to receive(:update_shape_from_overpass).with(1)
      POIUpdateShapeJob.perform_now(1)
    end
  end
end
