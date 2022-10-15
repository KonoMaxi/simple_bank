# frozen_string_literal: true

module Mutations
  class AccountingTransactionCreate < BaseMutation
    description "Creates a new accounting_transaction"

    field :accounting_transaction, Types::AccountingTransactionType, null: false

    argument :accounting_transaction_input, Types::AccountingTransactionInputType, required: true

    def resolve(accounting_transaction_input:)
      accounting_transaction = ::AccountingTransaction.new(**accounting_transaction_input)
      raise GraphQL::ExecutionError.new "Error creating accounting_transaction", extensions: accounting_transaction.errors.to_hash unless accounting_transaction.save

      { accounting_transaction: accounting_transaction }
    end
  end
end
