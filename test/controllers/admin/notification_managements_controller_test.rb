require "test_helper"

class Admin::NotificationManagementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_notification_managements_index_url
    assert_response :success
  end
end
