# frozen_string_literal: true

require 'rails_helper'

describe SynchronizeGeographyJob, type: :job do
  describe '#perform_later' do
    it 'enqueues the job' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        described_class.perform_later
      end.to have_enqueued_job
    end
  end
end
