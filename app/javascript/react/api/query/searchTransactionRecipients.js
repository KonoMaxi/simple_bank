import { gql } from "graphql-request";
import { useQuery } from "@tanstack/react-query";
import graphQLClient from '..'

const transaction_recipients_query = gql`
  query SearchTransactionRecipient ($searchTerm: String!)  {
    transactionRecipients(searchTerm: $searchTerm) {
      id
      email
    }
  }
`

export default async function searchTransactionRecipients (searchTerm) {
  const { transactionRecipients } = await graphQLClient.request(
    transaction_recipients_query,
    { searchTerm: searchTerm }
  )
  return transactionRecipients
}
