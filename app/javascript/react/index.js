import React from "react"
import ReactDOM from "react-dom/client"
import {
  QueryClient,
  QueryClientProvider,
} from "@tanstack/react-query"
import {
  BrowserRouter,
} from "react-router-dom";
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'

import App from "./app"
const queryClient = new QueryClient()

document.addEventListener("DOMContentLoaded", () => {
  const reactRoot = document.getElementById("root")
  if (reactRoot) {
    ReactDOM.createRoot(
      reactRoot
    ).render(
      <QueryClientProvider client={queryClient}>
        <BrowserRouter>
          <App/>
        </BrowserRouter>
        <ReactQueryDevtools initialIsOpen={false} />
      </QueryClientProvider>
    )
  }
})
