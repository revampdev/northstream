class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.references :order, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.integer :amount

      t.timestamps
    end
  end
end
