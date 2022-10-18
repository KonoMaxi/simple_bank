import React from 'react'

import { Outlet } from "react-router-dom"
import { csrfToken } from "../api"
import { Greeting } from '../components'
import { QueryClient, QueryClientProvider, useQuery } from '@tanstack/react-query'

export default function Root() {
  return (
    <>
      <div className="sidebar">
        <h1>Bankington Bank</h1>
        <Greeting></Greeting>
        <button onClick={() => {
          fetch('/users/sign_out', {
            method: 'DELETE', headers: {"X-CSRF-Token": csrfToken }
          }).then(response => {
            window.location.href = "/users/sign_in"
          })
        }}>Log Out</button>
      </div>
      <div className="detail">
        <Outlet/>
      </div>
    </>
  )
}
