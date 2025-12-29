class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :
  # before_action :authenticate_user!

  

  private


  def after_sign_in_path_for(resource)
    anniversaries_path
  end

  # before_action :set_header_visibility
  #  # デフォルトはヘッダーを表示する
  # def set_header_visibility
  #   @show_header = true 
  # end



  # def after_sign_out_path_for(resource_or_scope)
  #   root_path
  # end
end
