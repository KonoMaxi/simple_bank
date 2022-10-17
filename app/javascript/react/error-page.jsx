import React from "react"
import { Link } from "react-router-dom"

export default function ErrorPage() {
  return (
    <div id="error-page">
      <h1>Oops! 404</h1>
      <p>Sorry, we dont appear to have in stock what you are looking for!</p>
      <p>Common, let's head back <Link to="/">home</Link>!</p>
    </div>
  )
}
