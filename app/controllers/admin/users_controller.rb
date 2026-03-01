class Admin::UsersController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @q= User.ransack(params[:q])
    @users = @q.result(distince: true)
  end
end
