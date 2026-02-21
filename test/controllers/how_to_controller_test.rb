require "test_helper"

class HowToControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get how_to_show_url
    assert_response :success
  end
end
