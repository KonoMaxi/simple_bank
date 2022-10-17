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

export default async function queryBankAccount () {
  const { bankAccount } = await graphQLClient.request(
    bank_account_query
  )
  return bankAccount
}
