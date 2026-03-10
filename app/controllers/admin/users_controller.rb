class Admin::UsersController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @q= User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :asc).page(params[:page]).per(10)
  end
end
