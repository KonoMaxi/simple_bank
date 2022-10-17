import { gql } from "graphql-request";
import { useQuery } from "@tanstack/react-query";
import graphQLClient from '..'

const transaction_recipients_query = gql`
  query SearchTransactionRecipient ($searchTerm: String)  {
    transactionRecipients(searchTerm: $searchTerm) {
      id
      email
    }
  }
`

export default function useTransactionRecipients (searchTerm) {
  return useQuery(["transaction_recipients", "search"], async () => {
    const { transactionRecipients } = await graphQLClient.request(
      transaction_recipients_query,
      { searchTerm: searchTerm }
    )
    return transactionRecipients
  })
}
