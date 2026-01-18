require "test_helper"

class GiftSuggestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get gift_suggestions_new_url
    assert_response :success
  end

  test "should get create" do
    get gift_suggestions_create_url
    assert_response :success
  end
end
