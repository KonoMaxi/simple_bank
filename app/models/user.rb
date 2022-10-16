class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :debit_accounting_transactions, class_name: "AccountingTransaction", foreign_key: "debit_account_id"
  has_many :credit_accounting_transactions, class_name: "AccountingTransaction", foreign_key: "credit_account_id"
  has_many :account_balances

  validates :email, uniqueness: true

  def current_balance
    account_balances.order(created_at: :desc).first
  end

end
