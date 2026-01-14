# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  def line
    @user = User.from_line(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in(@user)
      redirect_to user_root_path, notice: "LINEログイン成功"
    else
      session["devise.line_data"] = request.env["omniauth.auth"].except("extra")
    rescue OAuth2::Error => e
      redirect_to rootpath, alert: "LINE認証に失敗しました（#{e.message}）"
  end

  def failure
    redirect_to root_path, alert: "認証に失敗しました。再度お試しください。"
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
