# frozen_string_literal: true

module Types
  class BankAccountType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :current_balance, Float, null: true
    field :last_transaction_at, GraphQL::Types::ISO8601DateTime, null: true
    field :transactions, [Types::BankAccountTransactionType], null: true,
      description: "The list of all transactions"
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def transactions
      object.account_balances.includes(:accounting_transaction)
    end

    def last_transaction_at
      object.current_balance&.accounting_transaction&.date
    end

    def current_balance
      object.current_balance&.total
    end
  end
end