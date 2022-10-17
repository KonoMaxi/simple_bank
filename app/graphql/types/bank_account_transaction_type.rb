# frozen_string_literal: true

module Types
  class BankAccountTransactionType < Types::BaseObject
    field :id, ID, null: false
    field :total, Float, null: false
    field :change, Float, null: false
    field :date, GraphQL::Types::ISO8601DateTime, null: false
    field :direction, Types::BankAccountTransactionTypeEnumType, null: true
    field :accounting_transaction_id, ID, null: false
    field :transfer_email, String, null: false

    def direction
      object.accounting_transaction.debit_account_id == context[:current_user].id ? "IN" : "OUT"
    end

    def transfer_email
      if object.accounting_transaction.debit_account_id == context[:current_user].id
        return object.accounting_transaction.credit_account.email
      else
        return object.accounting_transaction.debit_account.email
      end
    end

    def date
      object.accounting_transaction.date
    end
  end
end
