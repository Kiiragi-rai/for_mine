class AnniversaryNotificationSettingForm
  include ActiveModel::API
  include ActiveModel::Attributes

  attr_accessor :user, :anniversary, :notification_setting

  attribute :title, :string
  attribute :anniversary_date, :date
  attribute :is_enabled, :boolean



  def initialize(user:, anniversary: nil,   **attrs)
    @user = user
    @anniversary = anniversary || user.anniversaries.build
    @notification_setting =  @anniversary.notification_setting || @anniversary.build_notification_setting



    defaults ={
      title: @anniversary.title,
      anniversary_date: @anniversary.anniversary_date,
      is_enabled: @notification_setting.is_enabled
    }

    super(defaults.merge(attrs))
  end

  def save
    return false unless valid?

    transfer_attributes

    ApplicationRecord.transaction do
     anniversary.save!
     notification_setting.save!
    end

    true

  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  # DB保存用
  def transfer_attributes
    anniversary.title = title
    anniversary.anniversary_date = anniversary_date
    notification_setting.is_enabled = is_enabled
  end
end
