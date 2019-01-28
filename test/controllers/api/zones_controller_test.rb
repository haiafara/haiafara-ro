require 'test_helper'

class API::ZonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @zone = zones(:two)
  end

  test "should return success" do
    get api_zone_url(@zone)
    assert_response :success
  end

  test 'should return correct content type' do
    get api_zone_url(@zone)
    assert_equal response.content_type, 'application/json'
  end
end
