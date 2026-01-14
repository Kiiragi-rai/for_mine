# frozen_string_literal: true

class DevSessionsController < ApplicationController
  def create
    user = User.first || User.create!(name: "Dev User", provider: "line", uid: SecureRandom.hex(8))
    sign_in(user)
    redirect_to user_root_path, notice: "Dev login OK"
  end

  def destroy
    sign_out(:user)
    redirect_to root_path, notice: "Dev logout OK"
  end
end
