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
  debit_account_id: maximilian.id,
  credit_account_id: alice.id,
  amount: 99.99,
  date: DateTime.now
)
AccountingTransaction.create(
  debit_account_id: alice.id,
  credit_account_id: bob.id,
  amount: 10,
  date: DateTime.now
)
AccountingTransaction.create(
  debit_account_id: bob.id,
  credit_account_id: maximilian.id,
  amount: 1.01,
  date: DateTime.now
)
