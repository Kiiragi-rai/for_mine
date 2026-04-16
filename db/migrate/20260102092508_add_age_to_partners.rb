class AddAgeToPartners < ActiveRecord::Migration[7.2]
  def change
    add_column :partners, :age, :integer
  end
end
