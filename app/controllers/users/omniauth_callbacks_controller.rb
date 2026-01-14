# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def line
    @user = User.from_line(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in(@user)
      redirect_to user_root_path, notice: "LINEログイン成功"
    else
      session["devise.line_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to root_path, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path, alert: "認証に失敗しました。再度お試しください。"
  end

  private

def after_omniauth_failure_path_for(_scope)
  root_path
end
end


