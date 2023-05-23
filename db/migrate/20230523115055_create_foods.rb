class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: false
      t.decimal :price, deafult: 0.0
      t.integer :quantity, null: false
      t.float :measurement_unit

      t.timestamps
    end
  end
end
