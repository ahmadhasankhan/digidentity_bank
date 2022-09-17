class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :title
      t.string :ownership
      t.integer :property_type, default: 0, null: false
      t.integer :nature_of_property, default: 0, null: false
      t.float :price
      t.float :current_bid
      t.text :address
      t.float :total_area
      t.integer :status, default: 0, null: false
      t.float :lat
      t.float :long
      t.integer :city_id

      t.timestamps
    end
  end
end
