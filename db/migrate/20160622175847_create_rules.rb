class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :title
      t.text :content
      t.date :created_at
      t.date :updated_at
      t.date :valid_until
      t.integer :committee_id
      t.boolean :is_valid

      t.timestamps null: false
    end
  end
end
