import { gql } from "graphql-request";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import graphQLClient from '..'

const accounting_transaction_mutation = gql`
  mutation CreateAccountingTransaction(
    $debitAccountId: ID!,
    $amount: Float!,
  ) {
    createAccountingTransaction(input: {
      accountingTransactionInput: {
        debitAccountId: $debitAccountId
        amount: $amount
      }
    }) {
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
