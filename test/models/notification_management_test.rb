# == Schema Information
#
# Table name: notification_managements
#
#  id                      :bigint           not null, primary key
#  error_message           :string
#  schedule_title          :string
#  scheduled_for           :datetime         not null
#  sent_at                 :datetime
#  status                  :integer          default("pending"), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  notification_setting_id :bigint           not null
#
# Indexes
#
#  index_notification_managements_on_notification_setting_id  (notification_setting_id)
#  index_notification_managements_unique_schedule             (notification_setting_id,scheduled_for) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (notification_setting_id => notification_settings.id)
#
require "test_helper"

class NotificationManagementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
