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

  describe 'scopes' do
    let(:zone) { create(:zone) }

    describe '.with_expanded_bounding_box' do
      subject { Zone.with_expanded_bounding_box.find(zone.id) }

      it 'defines an .expanded_bounding_box property' do
        expect(subject.expanded_bounding_box).not_to be_nil
      end

      it 'returns the correct expanded bounding box' do
        expect(subject.expanded_bounding_box.as_text).to eq(
          'POLYGON ((23.557 47.602, 23.557 47.722, ' +
          '23.837000000000003 47.722, 23.837000000000003 47.602, ' +
          '23.557 47.602))'
        )
      end
    end
  end
end
