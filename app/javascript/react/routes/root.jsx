import React from 'react'
import { Outlet } from "react-router-dom"


export default function Root() {
  return (
    <>
      <div id="sidebar">
        <h1>React Router Skeleton</h1>
        {/*<div>
          <form id="search-form" role="search">
            <input
              id="q"
              aria-label="Search contacts"
              placeholder="Search"
              type="search"
              name="q"
            />
            <div
              id="search-spinner"
              aria-hidden
              hidden={true}
            />
            <div
              className="sr-only"
              aria-live="polite"
            ></div>
          </form>
        </div>*/}
      </div>
      <div id="detail">
        <Outlet/>
      </div>
    </>
  )
}
