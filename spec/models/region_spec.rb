require 'rails_helper'

RSpec.describe Region, type: :model do
  subject { described_class.new }

  it 'is valid without any attributes' do
    expect(subject).to be_valid
  end
end
