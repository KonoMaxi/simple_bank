# frozen_string_literal: true

module Mutations
  class AccountingTransactionCreate < BaseMutation
    description "Creates a new accounting transaction and return the new account_balance"

    argument :accounting_transaction_input, Types::AccountingTransactionInputType, required: true

    field :success, Boolean, null: false
    field :balance, Types::BankAccountTransactionType, null: true,
      description: "The balance after this transaction"

    def resolve(accounting_transaction_input:)
      acc_tra = AccountingTransaction.new(
        **accounting_transaction_input,
        date: DateTime.now,
        credit_account_id: context[:current_user].id
      )
      if acc_tra.save
        acccount_balance = acc_tra.account_balances.find_sole_by(user: context[:current_user])
        { success: true, balance: acccount_balance }
      else
        raise GraphQL::ExecutionError.new(acc_tra.errors.full_messages)
      end
    end
  end
end

