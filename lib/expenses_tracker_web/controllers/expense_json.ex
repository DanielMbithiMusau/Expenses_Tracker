defmodule ExpensesTrackerWeb.ExpenseJSON do
  alias ExpensesTracker.Expenses.Expense

  @doc """
  Renders a list of expenses.
  """
  def index(%{expenses: expenses}) do
    %{data: for(expense <- expenses, do: data(expense))}
  end

  @doc """
  Renders a single expense.
  """
  def show(%{expense: expense}) do
    %{data: data(expense)}
  end

  defp data(%Expense{} = expense) do
    %{
      id: expense.id,
      amount: expense.amount,
      paid_to: expense.paid_to
    }
  end
end
