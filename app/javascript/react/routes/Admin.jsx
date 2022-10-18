import React from "react"
import { Link } from "react-router-dom";
import { queryAdminOverview } from "../api"
import {
  useQuery,
  useInfiniteQuery,
  QueryClient,
  QueryClientProvider
} from '@tanstack/react-query'

export default function Admin() {

  const { data, error, isLoading } = useQuery(
    ['admin'],
    queryAdminOverview
  )

  if ( isLoading ) {
    return <p>Loading Transactions...</p>
  } else if ( error ) {
    return <p>We're facing some problems right now. Please try again later...</p>
  }
  return (
    <>
      <p>List of Accounts</p>
      {data.map((account) => (
        <div className={ account.currentBalance >= 0 ? 'card green' : 'card red'} key={account.id}>
          <p>User Email: {account.email}</p>
          <p>Account Balance: {account.currentBalance || 0}</p>
        </div>
      ))}
    </>
  )
}

