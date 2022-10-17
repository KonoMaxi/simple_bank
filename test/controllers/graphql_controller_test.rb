require "test_helper"

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:max)
    sign_in @user
  end

  test "requires sign_in" do
    sign_out @user
    query_string = "query {
        bankAccount {
          email
          currentBalance
          lastTransactionAt
        }
      }
    "
    post graphql_path, params: { query: query_string }
    assert_response :redirect
    assert_redirected_to new_user_session_url
  end

  test "should query bank_account" do
    query_string = "query {
        bankAccount {
          email
          currentBalance
          lastTransactionAt
        }
      }
    "
    post graphql_path, params: { query: query_string }
    json_response = @response.parsed_body

    assert_nil json_response["error"], "Expecting no errors"
    assert_equal(
      users(:max).current_balance.total,
      json_response["data"]["bankAccount"]["currentBalance"]
    )
    assert_equal(
      users(:max).email,
      json_response["data"]["bankAccount"]["email"],
      "Expecting no errors"
    )
  end

  test "should query bank_account transactions" do
    query_string = "query {
        bankAccount {
          transactions {
            nodes {
              total
            }
          }
        }
      }
    "
    post graphql_path, params: { query: query_string }
    json_response = @response.parsed_body

    assert_nil json_response["error"], "Expecting no errors"
    assert_equal(
      users(:max).account_balances.order(created_at: :desc).first.total,
      json_response["data"]["bankAccount"]["transactions"]["nodes"][0]["total"]
    )
  end

  test "should query transaction recipients" do
    query_string = "query {
      transactionRecipients(searchTerm: \"hanna\") {
        id
        email
      }
    }
    "
    post graphql_path, params: { query: query_string }
    json_response = @response.parsed_body

    assert_nil json_response["error"], "Expecting no errors"
    assert_equal(
      users(:eline).email,
      json_response["data"]["transactionRecipients"][0]["email"]
    )
    assert_equal 1, json_response["data"]["transactionRecipients"].count, "There should only be one match"
  end

  test "should mutate account_transaction" do
    query_string = "mutation {
      createAccountingTransaction(input: {
        accountingTransactionInput: {
          debitAccountId: #{users(:eline).id}
          amount: 123
        }
      }) {
        balance {
          total
        }
      }
    }"
    old_balance = @user.current_balance.total

    assert_difference(-> { @user.current_balance.total }, -123) do
      assert_difference("AccountingTransaction.count") do
        post graphql_path, params: { query: query_string }
      end
    end
    json_response = @response.parsed_body

    assert_nil json_response["error"], "Expecting no errors"
    assert_equal(
      old_balance - 123,
      json_response["data"]["createAccountingTransaction"]["balance"]["total"],
      "query returns new reduced balance"
    )
  end
end
