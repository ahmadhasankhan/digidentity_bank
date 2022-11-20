class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :reference_number, null: false
      t.decimal :amount
      t.integer :transaction_type, default: 0
      t.references :business, null: false, foreign_key: true
      t.integer :from_year, null: false
      t.integer :to_year, null: false
      t.integer :status, null: false, default: 0
      t.string :message
      t.timestamps
    end
  end
end
