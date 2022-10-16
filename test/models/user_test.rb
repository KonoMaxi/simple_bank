require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "has_many debit_accounting_transactions" do
    assert_equal 1, users(:max).debit_accounting_transactions.count
    assert_equal 2, users(:eline).debit_accounting_transactions.count
    assert_equal 0, users(:some_rich_dude).debit_accounting_transactions.count
  end

  test "has_many credit_accounting_transactions" do
    assert_equal 1, users(:max).credit_accounting_transactions.count
    assert_equal 0, users(:eline).credit_accounting_transactions.count
    assert_equal 2, users(:some_rich_dude).credit_accounting_transactions.count
  end

  test "validates email unique" do
    user =  User.new(
      email: users(:max).email,
      password: "hello_you!",
      password_confirmation: "hello_you!"
    )
    assert user.invalid?, "expecting user to be invalid"
    assert user.errors.key?(:email), "expecting email validation error"
  end

  test "validates email format" do
    user =  User.new(
      email: "not_an_email",
      password: "hello_you!",
      password_confirmation: "hello_you!"
    )
    assert user.invalid?, "expecting user to be invalid"
    assert user.errors.key?(:email), "expecting email validation error"
  end
end
