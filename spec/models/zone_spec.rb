require 'rails_helper'

RSpec.describe Zone, type: :model do
  subject { described_class.new }

  it 'is valid with valid attributes' do
    subject.region = Region.new
    expect(subject).to be_valid
  end

  it 'is not valid without a region' do
    expect(subject).not_to be_valid
  end
end
