module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :bank_account, Types::BankAccountType, null: false,
      description: "A users Bank account info"

    def bank_account
      context[:current_user]
    end
  end
end
