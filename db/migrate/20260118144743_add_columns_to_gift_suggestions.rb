class AddColumnsToGiftSuggestions < ActiveRecord::Migration[7.2]
  def change
    add_column :gift_suggestions, :input_json, :jsonb
    add_column :gift_suggestions, :result_json, :jsonb
    add_column :gift_suggestions, :status, :string
    add_column :gift_suggestions, :error_message, :text
  end
end
