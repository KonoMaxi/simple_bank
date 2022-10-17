import React from "react"
import {
  Routes,
  Route,
} from "react-router-dom"

import Root from "./routes/root"
import ListTransactions from "./routes/ListTransactions";
import NewTransaction from "./routes/NewTransaction";
import Admin from "./routes/Admin";

import ErrorPage from "./error-page"

import {
  useQuery,
  useMutation,
  useQueryClient,
  QueryClient,
  QueryClientProvider,
} from '@tanstack/react-query'

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Root />}>
        <Route
          path="/"
          element={<ListTransactions />}
        />
        <Route
          path="/accounting_transactions/new"
          element={<NewTransaction />}
        />
        <Route
          path="/admin"
          element={<Admin />}
        />
        <Route
          path="*"
          element={<ErrorPage />}
        />
      </Route>
    </Routes>
  )
}
