import { gql } from "graphql-request";
import { useQuery } from "@tanstack/react-query";
import graphQLClient from '..'

const bank_account_query = gql`
  query {
    bankAccount {
      email
      currentBalance
      lastTransactionAt
    }
  }
`

export default function useBankAccount () {
  return useQuery(["bank_account"], async () => {
    const { bankAccount } = await graphQLClient.request(
      bank_account_query
    )
    return bankAccount
  })
}
