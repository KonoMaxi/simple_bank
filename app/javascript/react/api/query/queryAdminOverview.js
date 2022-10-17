import { gql } from "graphql-request";
import { useQuery } from "@tanstack/react-query";
import graphQLClient from '..'

const admin_overview_query = gql`
  query {
    adminOverview {
      id
      email
      currentBalance
    }
  }
`

export default async function queryAdminOverview () {
  const { adminOverview } = await graphQLClient.request(
    admin_overview_query
  )
  return adminOverview
}
