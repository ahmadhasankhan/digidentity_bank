class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :registration_number
      t.integer :business_type
      t.string :owner_name
      t.string :father_name
      t.string :mobile
      t.string :address

      t.timestamps
    end
  end
end
