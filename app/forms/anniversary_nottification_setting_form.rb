class AnniversaryNotificationSetting
  include ActiveModel::API 
  include ActiveModel::Attributes

  attr_accessor :user, :anniversary, :notification_setting

  attribute :title, :string
  attribute :anniversary_date
  attribute :is_enabled

  

  def initialize()

  end

  def save (...)
    transfer_attributes


  end

  private 
  
  def transfer_attributes

  end
end