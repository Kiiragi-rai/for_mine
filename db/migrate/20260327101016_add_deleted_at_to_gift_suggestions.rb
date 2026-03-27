class AddDeletedAtToGiftSuggestions < ActiveRecord::Migration[7.2]
  def change
    add_column :gift_suggestions, :deleted_at, :datetime
  end
end
