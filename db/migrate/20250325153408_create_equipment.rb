class CreateEquipment < ActiveRecord::Migration[7.2]
  def change
    create_table :equipment do |t|
      t.string :name
      t.text :description
      t.string :category
      t.decimal :price
      t.boolean :available
      t.references :user, null: false, foreign_key: true
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
