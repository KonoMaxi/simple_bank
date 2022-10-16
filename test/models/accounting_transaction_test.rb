require "test_helper"

class AccountingTransactionTest < ActiveSupport::TestCase
  test "validates date" do
    at = AccountingTransaction.new(
      amount: 19.99,
      debit_account: users(:max),
      credit_account: users(:eline)
    )
    assert at.invalid?, "expecting accounting_transaction to be invalid"
    assert at.errors.key?(:date), "expecting date validation error"
  end

  test "validates amount" do
    at = AccountingTransaction.new(
      date: DateTime.now,
      debit_account: users(:max),
      credit_account: users(:eline)
    )
    assert at.invalid?, "expecting accounting_transaction to be invalid"
    assert at.errors.key?(:amount), "expecting amount validation error"
  end

  test "debit and credit account are not equal" do
    at = AccountingTransaction.new(
      date: DateTime.now,
      amount: 10,
      debit_account: users(:max),
      credit_account: users(:max)
    )
    assert at.invalid?, "expecting accounting_transaction to be invalid"
    assert at.errors.key?(:debit_account), "expecting debit_account validation error"
  end

  test "complete record validates correctly" do
    assert_difference("AccountingTransaction.count", 1) do
      users(:eline).debit_accounting_transactions.build(
        amount: 10,
        date: DateTime.now - 1.week,
        credit_account_id: users(:max).id
      ).save
    end
  end

  test "new accounting_transaction creates two new account_balances" do
    assert_difference("AccountBalance.count", 2) do
      AccountingTransaction.create(
        amount: 10,
        date: DateTime.now,
        debit_account: users(:max),
        credit_account: users(:eline)
      )
    end
  end


end
