class Admin::DashboardController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @users = User.all.count
    @notification_managements = NotificationManagement.all.failure.count
    @gift_failures = GiftSuggestion.all.failure.count
  end
end
