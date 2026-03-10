class Admin::NotificationManagementsController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @q= NotificationManagement.ransack(params[:q])
    @notification_managements = @q.result(distinct: true).order(created_at: :asc).page(params[:page]).per(10)
  end
end
