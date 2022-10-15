# frozen_string_literal: true

module Types
  class BankAccountTransactionTypeEnumType < Types::BaseEnum
    value "IN", "money going your way"
    value "OUT", "funds facing away"
  end
end
