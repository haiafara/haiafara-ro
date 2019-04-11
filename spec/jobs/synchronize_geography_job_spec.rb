# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SynchronizeGeographyJob, type: :job do
  describe '#perform_later' do
    it 'enqueues the job' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        SynchronizeGeographyJob.perform_later
      }.to have_enqueued_job
    end
  end
end
