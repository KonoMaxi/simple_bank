# frozen_string_literal: true

module Types
  class BankAccountType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :current_balance, Float, null: true
    field :last_transaction_at, GraphQL::Types::ISO8601DateTime, null: true
    field :transactions, Types::BankAccountTransactionType.connection_type,
      null: true, default_page_size: 10,
      description: "The list of all transactions"
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def transactions
      object.account_balances.order(created_at: :desc).includes(accounting_transaction: [ :debit_account, :credit_account ])
    end

    def last_transaction_at
      object.current_balance&.accounting_transaction&.date
    end

    def current_balance
      object.current_balance&.total
    end
  end
end
