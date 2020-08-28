# frozen_string_literal: true

require 'rails_helper'

describe Zone, type: :model do
  subject(:instance) { described_class.new }

  it 'is valid with valid attributes' do
    instance.region = Region.new
    expect(instance).to be_valid
  end

  it 'is not valid without a region' do
    expect(instance).not_to be_valid
  end

  describe 'scopes' do
    let(:zone) { create(:zone) }
    let(:expanded_bounding_box_text) do
      'POLYGON ((23.557 47.602, 23.557 47.722, ' \
      '23.837000000000003 47.722, 23.837000000000003 47.602, ' \
      '23.557 47.602))'
    end

    describe '.with_expanded_bounding_box' do
      subject(:zone_with_expanded_bounding_box) do
        described_class.with_expanded_bounding_box.find(zone.id)
      end

      it 'defines an .expanded_bounding_box property' do
        expect(
          zone_with_expanded_bounding_box.expanded_bounding_box
        ).not_to be_nil
      end

      it 'returns the correct expanded bounding box' do
        expect(
          zone_with_expanded_bounding_box.expanded_bounding_box.as_text
        ).to eq(
          expanded_bounding_box_text
        )
      end
    end
  end
end
