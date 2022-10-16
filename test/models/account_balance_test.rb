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
    ab = AccountBalance.new(
      total: 19.99,
      user: @user,
      accounting_transaction: @accounting_transaction
    )
    assert ab.invalid?, "expecting account_balance to be invalid"
    assert ab.errors.key?(:change), "expecting account_balance to be invalid"
  end

  test "validates total present" do
    ab = AccountBalance.new(
      change: 10,
      user: @user,
      accounting_transaction: @accounting_transaction
    )
    assert ab.invalid?, "expecting account_balance to be invalid"
    assert ab.errors.key?(:total), "expecting account_balance to be invalid"
  end

  test "balances are updated correctly" do
    transferred_amount = 10
    eline_balance = users(:eline).current_balance.total
    max_balance = users(:max).current_balance.total

    assert_changes(
      ->{ users(:eline).current_balance.total },
      from: eline_balance,
      to: eline_balance + transferred_amount
    ) do
      assert_changes(
        ->{ users(:max).current_balance.total },
        from: max_balance,
        to: max_balance - transferred_amount
      ) do
        AccountingTransaction.create!(
          amount: transferred_amount,
          debit_account_id: users(:eline).id,
          credit_account_id: users(:max).id,
          date: DateTime.now
        )
      end
    end
  end
end
