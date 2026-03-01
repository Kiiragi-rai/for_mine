class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :
  # before_action :authenticate_user!

  add_flash_types :success, :danger


  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when User 
      if !resource.first_login_flag?
        resource.update_column(:first_login_flag, true)
        # how_to_show_path
        flash[:notice] = "使い方ページ読んでね！"
        root_path
      else
        flash[:notice] = "ログイン成功"
        root_path       
      end
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
