# frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe PromoteJob, type: :job do
#   describe '#perform_later' do
#     it 'enqueues the job' do
#       ActiveJob::Base.queue_adapter = :test
#       expect do
#         PromoteJob.perform_later(1)
#       end.to have_enqueued_job
#     end

#     it 'calls the correct service method' do
#       expect(Shrine::Attacher).to receive(:promote).with(1)
#       PromoteJob.perform_now(1)
#     end
#   end
# end
