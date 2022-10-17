import React from 'react'

import { useBankAccount } from '../api'

export default function Greeting() {
  const { isLoading, error, data } = useBankAccount()

  if (error) {
    return "Sorry, but we ran into an error. Please try again later"
  }
  if (isLoading) {
    return "Fetching your data..."
  }

  let teaser
  if ( data.currentBalance > 0) {
    teaser = <p>How about spending your { data.currentBalance }€ on useless consumer goods?</p>
  } else {
    teaser = <p>You are broke man, your balance is at { data.currentBalance }€</p>
  }
  return (
    <>
      <p>Hello {data.email},<br/>Welcome Back</p>
      { teaser }
    </>
  )
}
