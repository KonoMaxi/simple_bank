import React from "react"
import { Link } from "react-router-dom";
import { queryBankAccountTransactions } from "../api"
import {
  useQuery,
  useInfiniteQuery,
  QueryClient,
  QueryClientProvider
} from '@tanstack/react-query'

export default function ListTransactions() {

  const {
    status,
    data,
    isFetching,
    isFetchingNextPage,
    fetchNextPage,
    hasNextPage,
  } = useInfiniteQuery(
    ['bank_account', 'transactions'],
    ({ pageParam = "" }) => {
      return queryBankAccountTransactions(pageParam)
    },
    {
      getNextPageParam: (lastPage) => lastPage.pageInfo.endCursor ?? undefined,
    },
  )

  if ( status === 'loading' ) {
    return <p>Loading Transactions...</p>
  }
  return (
    <>
      <p>List of transactions</p>
      <Link to="/accounting_transactions/new">New Transaction</Link>
      {data.pages.map((page) => (
        <React.Fragment key={page.pageInfo.endCursor}>
          {page.nodes.map((transaction) => (
            <div className={ transaction.direction == "IN" ? 'card green' : 'card red'} key={transaction.accountingTransactionId}>
              <p>Date: {transaction.date}</p>
              <p>{(transaction.direction == "IN" ? "From" : "To")}: {transaction.transferEmail}</p>
              <p>Amount: {transaction.change}</p>
            </div>
          ))}
        </React.Fragment>
      ))}
      <div>
        <button
          onClick={() => fetchNextPage()}
          disabled={!hasNextPage || isFetchingNextPage}
        >
          {isFetchingNextPage
            ? 'Loading more...'
            : hasNextPage
            ? 'Load more'
            : 'Nothing more to load'}
        </button>
      </div>
    </>
  )
}

