class Admin::NotificationManagementsController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @q= NotificationManagement.ransack(params[:q])
    @notification_managements = @q.result(distince: true)
  end
end
