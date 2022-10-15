class AccountingTransaction < ApplicationRecord
  belongs_to :debit_account, class_name: "User"
  belongs_to :credit_account, class_name: "User"

  validates :date, presence: true
  validates :amount, presence: true
end
