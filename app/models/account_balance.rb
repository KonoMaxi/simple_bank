class AccountBalance < ApplicationRecord
  belongs_to :user
  belongs_to :accounting_transaction

  validates :total, presence: true
  validates :change, presence: true
end
