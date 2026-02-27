class Admin::NotificationManagementsController < Admin::BaseController
  def index
    @notification_managements = NotificationManagement.order(created_at: :desc)
  end
end
