class Admin::NotificationManagementsController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @notification_managements = NotificationManagement.order(created_at: :desc)
  end
end
