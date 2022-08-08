class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :account_number
      t.integer :account_type, default: 0
      t.references :user, null: false, foreign_key: true
      t.decimal :balance, default: 0

      t.timestamps
    end
  end
end
