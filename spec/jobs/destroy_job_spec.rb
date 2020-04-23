# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DestroyJob, type: :job do
  # describe '#perform_later' do
  #   it 'enqueues the job' do
  #     ActiveJob::Base.queue_adapter = :test
  #     expect do
  #       DestroyJob.perform_later(1)
  #     end.to have_enqueued_job
  #   end

  #   it 'calls the correct service method' do
  #     expect(Shrine::Attacher).to receive(:destroy).with(1)
  #     DestroyJob.perform_now(1)
  #   end
  # end
end
