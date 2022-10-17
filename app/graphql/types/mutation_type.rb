module Types
  class MutationType < Types::BaseObject

    field :create_accounting_transaction, mutation: Mutations::AccountingTransactionCreate

  end
end
