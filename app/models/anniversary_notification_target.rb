class AnniversaryNotificationTarget
  include ActiveModel::Model
  include ActiveModel::Attributes

  # user_id , start_on, end_onいらない

  attribute :user_id, :integer
  attribute :notification_setting_id, :integer
  attribute :scheduled_for, :datetime
  attribute :start_on, :date
  attribute :end_on, :date
  attribute :title, :string
end
