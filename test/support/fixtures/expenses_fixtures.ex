defmodule ExpensesTracker.ExpensesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ExpensesTracker.Expenses` context.
  """

  @doc """
  Generate a expense.
  """
  def expense_fixture(attrs \\ %{}) do
    {:ok, expense} =
      attrs
      |> Enum.into(%{
        amount: 42,
        paid_to: "some paid_to"
      })
      |> ExpensesTracker.Expenses.create_expense()

    expense
  end
end
