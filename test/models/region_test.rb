require 'test_helper'

class RegionTest < ActiveSupport::TestCase
  test 'valid region' do
    region = Region.new
    assert region.valid?
  end
end
