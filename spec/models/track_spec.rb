# frozen_string_literal: true

require 'rails_helper'

describe Track, type: :model do
  subject(:instance) { described_class.new }

  it 'is valid with valid attributes' do
    expect(instance).to be_valid
  end
end
