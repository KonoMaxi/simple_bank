class AccountingTransaction < ApplicationRecord
  belongs_to :debit_account, class_name: "User"
  belongs_to :credit_account, class_name: "User"
  has_many :account_balances

  validates :date, presence: true
  validates :amount, presence: true

  after_create :update_account_balances

  # To be clear: this piece of logic should run in a worker queue,
  # which correctly handles in-order-processing.
  #
  # I'm allowing myself to do this "the dirty way" for this small test-assignment
  # After all, financial transactions are a delicate topic ;-)
  def update_account_balances
    account_balances.build(
      user: debit_account,
      total: debit_account.current_balance&.total.to_f + amount,
      change: amount
    ).save
    account_balances.build(
      user: credit_account,
      total: credit_account.current_balance&.total.to_f - amount,
      change: amount * -1
    ).save
  end
end
