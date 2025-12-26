class CreateAnniversaries < ActiveRecord::Migration[7.2]
  def change
    create_table :anniversaries do |t|
      t.references :user, null: false, foreign_key: true

      t.string :title, null: false
      t.date :anniversary_date, null: false

      t.timestamps
    end
  end
end
