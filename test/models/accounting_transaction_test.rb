require "test_helper"

class AccountingTransactionTest < ActiveSupport::TestCase
  test "complete record validates correctly" do
    assert_difference("AccountingTransaction.count", 1) do
      users(:eline).debit_accounting_transactions.build(
        amount: 10,
        date: DateTime.now - 1.week,
        credit_account_id: users(:max).id
      ).save
    end
  end

  test "validates date" do
    assert_not AccountingTransaction.new(
      amount: 19.99,
      debit_account: users(:max),
      credit_account: users(:eline)
    ).valid?
  end

  test "validates amount" do
    assert_not AccountingTransaction.new(
      date: DateTime.now,
      debit_account: users(:max),
      credit_account: users(:eline)
    ).valid?
  end

end
