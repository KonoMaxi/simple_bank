import { gql } from "graphql-request";
import { useQuery } from "@tanstack/react-query";
import graphQLClient from '..'

const bank_account_query = gql`
  query QueryBankAccountTransactions($cursor: String) {
    bankAccount {
      transactions(after: $cursor) {
        pageInfo {
          hasNextPage
          endCursor
        }
        nodes {
          accountingTransactionId
          change
          total
          date
          direction
        }
      }
    }
  }
`

export default async function queryBankAccountTransactions (cursor) {
  const { bankAccount: {transactions} } = await graphQLClient.request(
    bank_account_query,
    { cursor }
  )
  return transactions
}
