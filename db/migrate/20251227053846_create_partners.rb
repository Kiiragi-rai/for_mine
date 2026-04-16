class CreatePartners < ActiveRecord::Migration[7.2]
  def change
    create_table :partners do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }

      t.string :name
      t.string :sex
      t.string :relation
      t.string :job

      t.text :favorites, array: true, default: []
      t.text :avoidances, array: true, default: []
      t.text :hobbies, array: true, default: []

      t.integer :budget_min
      t.integer :budget_max

      t.timestamps
    end
  end
end
