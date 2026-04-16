# == Schema Information
#
# Table name: partners
#
#  id         :bigint           not null, primary key
#  age        :integer
#  avoidances :text             default([]), is an Array
#  budget_max :integer
#  budget_min :integer
#  favorites  :text             default([]), is an Array
#  hobbies    :text             default([]), is an Array
#  job        :string
#  name       :string
#  relation   :string
#  sex        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_partners_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class PartnerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
