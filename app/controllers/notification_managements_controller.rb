class NotificationManagementsController < ApplicationController

  # コントローラー内いらない　destroyいる？admin 
  
  def new
    @notification_management = NotificationManagement.new
  end

  def create
   @notification_management = NotificationManagement.new(notification_management_params)
   @notification_management.save
  end

  def edit
    @notification_management = NotificationManagement.find(params[:id])
  end


  def update
    @notification_management = NotificationManagement.find(params[:id])
    @notification_management.update(notification_management_params)
  end

  def destroy
    @notification_management = NotificationManagement.find(params[:id])
    @notification_management.destroy
  end

  private

  def notification_management_params
    params.require(:notification_management).permit(:scheduled_for, :sent_at, :status, :error_message)
  end
end

# == Schema Information
#
# Table name: notification_managements
#
#  id                      :bigint           not null, primary key
#  error_message           :string
#  scheduled_for           :datetime         not null
#  sent_at                 :datetime
#  status                  :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  notification_setting_id :bigint           not null
#
# Indexes
