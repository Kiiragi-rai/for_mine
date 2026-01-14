# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def line
    auth = request.env["omniauth.auth"]
    @user = callback(auth)
    if @user.persisted?
      success_login
    else
      not_success_login(auth)
    end
  end

  def failure
    redirect_to root_path, alert: "認証に失敗しました。再度お試しください。"
  end

  private

  def callback(auth)
     User.from_line(auth)
  end

  def success_login
      sign_in(@user)
      redirect_to user_root_path, notice: "LINEログイン成功"
  end

  def not_success_login(auth)
    session["devise.line_data"] = auth.except("extra")
    redirect_to root_path, alert: @user.errors.full_messages.join("\n")
  end
end


