# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  first_login_flag :boolean          default(FALSE), not null
#  is_deleted       :boolean
#  name             :string           default(""), not null
#  provider         :string           default(""), not null
#  uid              :string           default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_provider_and_uid  (provider,uid) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
