class Admin::DashboardController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @users = User.all.count
    @notification_managements = NotificationManagement.all.count
  end
end
