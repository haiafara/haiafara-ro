require 'test_helper'

class ZonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @zone = zones(:one)
  end

  test "should show zone" do
    get zone_url(@zone)
    assert_response :success
  end
end
