import React from "react"
import {
  Routes,
  Route,
} from "react-router-dom"

import Root from "./routes/root"
import Contact from "./routes/contact";
// import Root, {
//   loader as rootLoader,
//   action as rootAction,
// } from "./routes/root";
import ErrorPage from "./error-page"


export default function App() {
  return (
    <React.StrictMode>
      <Routes>
        <Route path="/" element={<Root />}>
          <Route
            path="contacts/:contactId"
            element={<Contact />}
          />
        </Route>
      </Routes>
    </React.StrictMode>
  )
}
