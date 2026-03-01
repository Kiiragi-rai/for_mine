# frozen_string_literal: true

class DevSessionsController < ApplicationController
  def create
    user = User.first || User.create!(name: "Dev User", provider: "line", uid: SecureRandom.hex(8))
    sign_in(user)

    # if !user.first_login_flag?
    #   user.update!(first_login_flag: true)
    #   redirect_to how_to_show_path,notice: "呼んだらHOMEへ行ってね"
    # else
    after_sign_in_path_for(user)
    redirect_to root_path
    # end
  end

  def destroy
    sign_out(:user)
    redirect_to root_path, notice: "Dev logout OK"
  end
end
