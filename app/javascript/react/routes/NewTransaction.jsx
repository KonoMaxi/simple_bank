import React, { useState, useEffect } from "react"
import { useMutation, useQueryClient } from '@tanstack/react-query'
import { useForm } from "react-hook-form";
import { Link, useNavigate } from "react-router-dom";
import SelectSearch from 'react-select-search';

import { createAccountingTransaction, searchTransactionRecipients } from '../api'

export default function NewTransaction() {
  const { register, handleSubmit, setValue } = useForm()
  const queryClient = useQueryClient()
  const navigate = useNavigate()

  const mutation = useMutation(
    (values) => createAccountingTransaction(values),
    {
      onSuccess: ({ createAccountingTransaction }) => {
        queryClient.invalidateQueries(['bank_account'])
        navigate("/")
      }
    }
  )
  const recipientOptions = async function (searchterm) {
    if (!searchterm.length) {
      return Promise.resolve([])
    }
    return new Promise((resolve, reject) => {
      searchTransactionRecipients(searchterm)
        .then(recipients => {
          resolve(recipients.map(({ id, email }) => ({ value: id, name: email })))
        })
        .catch(error => {
          reject()
        })
    })
  }

  const [ recipientId, setRecipientId] = useState()
  useEffect(() => {
    setValue('debitAccountId', recipientId)
  }, [ recipientId ])

  return (
    <>
      <Link to="/">Back</Link>
      <form onSubmit={handleSubmit(mutation.mutate)}>
        {mutation.error && (
          <ul onClick={() => mutation.reset()}>
            {
              mutation.error.map((message, idx) => {
                return (
                  <li key={idx}>{message}</li>
                )
              })
            }
          </ul>
        )}
        <label htmlFor="debit_account_id">Who is the Recipient?</label>
        <SelectSearch
          search
          options={[]}
          onChange={(val) => {
            setRecipientId(val)}
          }
          getOptions={recipientOptions}
          placeholder="Choose a recipient"
        />
        <p>Hint: Try looking for "kon", "bob" or "alice"</p>
        <div>
          <label htmlFor="amount">Amount</label>
          <input type="number" step="0.01" {...register('amount', { valueAsNumber: true })} defaultValue="0" />
        </div>
        <input type="submit" />
      </form>
    </>
  )
}

