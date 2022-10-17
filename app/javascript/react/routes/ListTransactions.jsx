import React from "react"
import { Link } from "react-router-dom";


export default function ListTransactions() {

  return (
    <>
      <Link to="/accounting_transactions/new">New Transaction</Link>
      <p>List Transaction</p>
    </>
  )
  // return (
  //   <div id="contact">
  //     <div>
  //       <img
  //         key={contact.avatar}
  //         src={contact.avatar || null}
  //       />
  //     </div>

  //     <div>
  //       <h1>
  //         {contact.first || contact.last ? (
  //           <>
  //             {contact.first} {contact.last}
  //           </>
  //         ) : (
  //           <i>No Name</i>
  //         )}{" "}
  //       </h1>

  //       {contact.twitter && (
  //         <p>
  //           <a
  //             target="_blank"
  //             href={`https://twitter.com/${contact.twitter}`}
  //           >
  //             {contact.twitter}
  //           </a>
  //         </p>
  //       )}

  //       {contact.notes && <p>{contact.notes}</p>}

  //     </div>
  //   </div>
  // );
}

