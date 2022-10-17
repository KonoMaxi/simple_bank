import { gql } from "graphql-request";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import graphQLClient from '..'

const accounting_transaction_mutation = gql`
  mutation CreateAccountingTransaction(
    $debitAccountId: ID!,
    $amount: Float!,
    $date: ISO8601DateTime!
  ) {
    createAccountingTransaction(input: {
      accountingTransactionInput: {
        debitAccountId: $debitAccountId
        date: $date
        amount: $amount
      }
    }) {
      success
      errors
      balance {
        total
      }
    }
  }
`
export default async function createAccountingTransaction (accountingTransactionInput) {
  try {
    return await graphQLClient.request(
      accounting_transaction_mutation,
      accountingTransactionInput
    )
  } catch (error) {
    throw error.response.errors.map(x => {
      try {
        return JSON.parse(x.message)
      } catch {
        return x.message
      }
    }).flat()
  }
}
