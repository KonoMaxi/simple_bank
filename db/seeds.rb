# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

maximilian = User.create(email: "maximilian@konow.ski", password: "h3lloMax!")
alice = User.create(email: "alice@konow.ski", password: "h3lloAlice")
bob = User.create(email: "bob@konow.ski", password: "h3lloBobby")

AccountingTransaction.create(
  debit_account: maximilian,
  credit_account: alice,
  amount: 99.99
)
AccountingTransaction.create(
  debit_account: alice,
  credit_account: bob,
  amount: 10
)
AccountingTransaction.create(
  debit_account: maximilian,
  credit_account: bob,
  amount: 1.01
)
