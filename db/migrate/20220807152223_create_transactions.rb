class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :reference_number, null: false
      t.decimal :amount
      t.integer :transaction_type, default: 0
      t.references :account, null: false, foreign_key: true
      t.integer :receiver_id, null: false # Change integer field to string to accept the world wide account number
      t.integer :status, null: false, default: 0
      t.string :message
      t.timestamps
    end
  end
end
