class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :iso
      t.string :iso3
      t.string :nicename
      t.integer :numcode
      t.integer :phonecode
    end
  end
end
