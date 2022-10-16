module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :bank_account, Types::BankAccountType, null: false,
      description: "A users Bank account info"

    field :transaction_recipients, [Types::UserType], null: false,
      description: "Available users to send money to" do
        argument :search_term, String, validates: { length: { minimum: 3 } }
        argument :limit, Integer, default_value: 10,
          validates: { numericality: { less_than_or_equal_to: 25 } }

    end

    def bank_account
      context[:current_user]
    end

    def transaction_recipients(search_term:, limit:)
      User.
        order(:email).excluding(context[:current_user]).
        search_by_email(search_term).limit(limit)
    end
  end
end
