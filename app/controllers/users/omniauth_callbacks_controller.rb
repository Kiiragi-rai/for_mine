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
  rescue StandardError => e
    Rails.logger.error(" LINE LOGIN ERROR 発生 #{e.full_message}")
    redirect_to root_path, alert: "LINEログイン中にエラーが発生しました。"
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
      if @user.first_login_flag?
      redirect_to user_root_path, notice: "おかえりなさい😊\n今日も大切な日を見てみようか"
      else 
        @user.update_column(:first_login_flag, true)
        redirect_to user_root_path, notice: "ようこそ😊\nまずは使い方を見てみようか"
      end
  end

  def not_success_login(auth)
    session["devise.line_data"] = auth.except("extra")
    redirect_to root_path, alert: @user.errors.full_messages.join("\n")
  end
end
