import React from 'react'

import { Outlet } from "react-router-dom"

import { Greeting } from '../components'
import { QueryClient, QueryClientProvider, useQuery } from '@tanstack/react-query'

export default function Root() {
  return (
    <>
      <div className="sidebar">
        <h1>Bankington Bank</h1>
        <Greeting></Greeting>
      </div>
      <div className="detail">
        <Outlet/>
      </div>
    </>
  )
}
