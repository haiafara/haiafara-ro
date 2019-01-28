require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to default zone" do
    get pages_home_url
    assert_redirected_to zone_url(zones(:two).slug)
  end
end
