class CreateAccountBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :account_balances do |t|
      t.references :user, null: false, foreign_key: true
      t.references :accounting_transaction, null: false, foreign_key: true
      t.decimal :change, null: false, precision: 10, scale: 4
      t.decimal :total, null: false, precision: 10, scale: 4

      t.timestamps
    end
  end
end
