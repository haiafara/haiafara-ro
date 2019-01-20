require 'test_helper'

class ZoneTest < ActiveSupport::TestCase
  test 'valid zone' do
    region = Region.first
    zone = Zone.new(region: region)
    assert zone.valid?
  end

  test 'zone is not valid without a region' do
    zone = Zone.new(name: 'Zone')
    refute zone.valid?
  end
end
