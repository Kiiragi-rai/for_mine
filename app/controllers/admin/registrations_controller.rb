class Admin::RegistrationsController < ApplicationController
  def new
    redirect_to admin_root_path, alert: "Adminの新規登録は禁止されています"
  end

  def create
    redirect_to admin_root_path, alert: "Adminの新規登録は禁止されています"
  end
end
