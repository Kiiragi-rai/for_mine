class Admin::DashboardController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @users = User.count
    @notification_managements = NotificationManagement.failure.count
    @gift_failures = GiftSuggestion.failure.count
  end
end
