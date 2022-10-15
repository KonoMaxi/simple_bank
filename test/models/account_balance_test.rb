require "test_helper"

class AccountBalanceTest < ActiveSupport::TestCase
  setup do
    @user = users(:max)
    @accounting_transaction = AccountingTransaction.create(
      debit_account_id: @user.id,
      credit_account_id: users(:some_rich_dude).id,
      amount: 100,
      date: DateTime.now
    )
  end

  test "complete record validates correctly" do
    assert_difference("AccountBalance.count", 1) do
      @user.account_balances.build(
        change: @accounting_transaction.amount,
        total: @user.current_balance.total + @accounting_transaction.amount,
        accounting_transaction: @accounting_transaction
      ).save!
    end
  end

  test "validates change present" do
    assert_not AccountBalance.new(
      total: 19.99,
      user: @user,
      accounting_transaction: @accounting_transaction
    ).valid?
  end

  test "validates total present" do
    assert_not AccountBalance.new(
      change: 10,
      user: @user,
      accounting_transaction: @accounting_transaction
    ).valid?
  end
end
