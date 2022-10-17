import { GraphQLClient, gql } from "graphql-request";

const API_URL = "/graphql"

const csrfToken = document.head.querySelector(`meta[name="csrf-token"]`).content
const graphQLClient = new GraphQLClient(API_URL, {
  headers: {
    "X-CSRF-Token": csrfToken
  }
})

export default graphQLClient
export { default as useBankAccount } from './query/useBankAccount';
export { default as useTransactionRecipients } from './query/useTransactionRecipients.js';
export { default as createAccountingTransaction } from './mutation/createAccountingTransaction.js';
