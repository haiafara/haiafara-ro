# frozen_string_literal: true

require 'rails_helper'

describe Region, type: :model do
  subject(:instance) { described_class.new }

  it 'is valid without any attributes' do
    expect(instance).to be_valid
  end
end
