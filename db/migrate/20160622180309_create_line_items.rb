class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :rule, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
