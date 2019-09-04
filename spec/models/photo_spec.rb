# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Photo, type: :model do
  Sidekiq::Testing.inline!
  context 'with image' do
    let(:photo) { create(:photo, photoable: build(:poi)) }
    it 'generates image versions' do
      ActiveJob::Base.queue_adapter =
        Rails.application.config.active_job.queue_adapter
      expect(photo.reload.image.keys).to eq(%i[original extralarge large medium thumbnail])
    end
  end
end
