class ChangeStatusToIntegerInGiftSuggestions < ActiveRecord::Migration[7.2]
  def change
    change_column :gift_suggestions,
                  :status,
                  :integer,
                  using: '0',
                  default: 0,
                  null: false
  end
end
