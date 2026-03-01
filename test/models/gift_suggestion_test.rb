# == Schema Information
#
# Table name: gift_suggestions
#
#  id            :bigint           not null, primary key
#  error_message :text
#  input_json    :jsonb
#  result_json   :jsonb
#  status        :integer          default("pending"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_gift_suggestions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class GiftSuggestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
