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

  test 'geometry field behaves as geometry' do
    assert_equal zones(:two)['bounding_box'].to_s, 'POLYGON ((23.669 47.65, 23.725 47.65, 23.725 47.674, 23.669 47.674, 23.669 47.65))'
  end
end
