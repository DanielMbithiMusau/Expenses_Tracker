defmodule ExpensesTrackerWeb.ExpenseTypeJSON do
  alias ExpensesTracker.ExpenseTypes.ExpenseType

  @doc """
  Renders a list of expense_types.
  """
  def index(%{expense_types: expense_types}) do
    %{data: for(expense_type <- expense_types, do: data(expense_type))}
  end

  @doc """
  Renders a single expense_type.
  """
  def show(%{expense_type: expense_type}) do
    %{data: data(expense_type)}
  end

  defp data(%ExpenseType{} = expense_type) do
    %{
      id: expense_type.id,
      name: expense_type.name
    }
  end
end
