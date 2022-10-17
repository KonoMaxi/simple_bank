import React from "react"
import { useMutation, useQueryClient } from '@tanstack/react-query'
import { useForm } from "react-hook-form";
import { Link } from "react-router-dom";

import { createAccountingTransaction } from '../api'

export default function NewTransaction() {
  const { register, handleSubmit } = useForm()
  const mutation = useMutation(
    (values) => createAccountingTransaction(values),
    {
      onSuccess: ({ createAccountingTransaction }) => {
        queryClient.invalidateQueries(['bank_account'])
      }
    }
  )

  const queryClient = useQueryClient()
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
        <div>
          <label htmlFor="debit_account_id">Who is the Recipient?</label>
          <input type="number" {...register('debitAccountId')} />
        </div>
        <div>
          <label htmlFor="date">Date</label>
          <input {...register('date', { valueAsDate: true })} defaultValue={ new Date().toISOString() } />
        </div>
        <div>
          <label htmlFor="amount">Amount</label>
          <input type="number" step="0.01" {...register('amount', { valueAsNumber: true })} defaultValue="0" />
        </div>
        <input type="submit" />
      </form>
    </>
  )
}

