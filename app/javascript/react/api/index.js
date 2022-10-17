import { GraphQLClient, gql } from "graphql-request";

const API_URL = "/graphql"

const csrfToken = document.head.querySelector(`meta[name="csrf-token"]`).content
const graphQLClient = new GraphQLClient(API_URL, {
  headers: {
    "X-CSRF-Token": csrfToken
  }
})

export default graphQLClient

export { default as queryAdminOverview } from './query/queryAdminOverview.js';
export { default as queryBankAccount } from './query/queryBankAccount';
export { default as searchTransactionRecipients } from './query/searchTransactionRecipients.js';
export { default as queryBankAccountTransactions } from './query/queryBankAccountTransactions';

export { default as createAccountingTransaction } from './mutation/createAccountingTransaction.js';
