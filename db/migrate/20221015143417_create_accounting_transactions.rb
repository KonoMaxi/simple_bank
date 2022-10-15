class CreateAccountingTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :accounting_transactions do |t|
      t.references :debit_account, foreign_key: { to_table: :users }, index: true
      t.references :credit_account, foreign_key: { to_table: :users }, index: true
      t.datetime :date, null: false
      t.decimal :amount, null: false, precision: 10, scale: 4

      t.timestamps
    end
  end
end
