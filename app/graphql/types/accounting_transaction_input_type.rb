# frozen_string_literal: true

module Types
  class AccountingTransactionInputType < Types::BaseInputObject
    argument :debit_account_id, ID, required: true
    argument :date, GraphQL::Types::ISO8601DateTime, required: true
    argument :amount, Float, required: true
  end
end
