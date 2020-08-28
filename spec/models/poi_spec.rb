# frozen_string_literal: true

require 'rails_helper'

describe POI, type: :model do
  subject(:instance) { described_class.new }

  it 'is valid with valid attributes' do
    expect(instance).to be_valid
  end

  describe '#save' do
    it 'calls POIUpdateShapeJob.perform_later via the after_save callback' do
      allow(POIUpdateShapeJob).to receive(:perform_later)
      instance.save
      expect(POIUpdateShapeJob).to have_received(:perform_later).with(instance.reload.id)
    end
  end
end
