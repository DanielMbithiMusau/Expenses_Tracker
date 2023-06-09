defmodule ExpensesTrackerWeb.ExpenseController do
  use ExpensesTrackerWeb, :controller

  alias ExpensesTracker.Expenses
  alias ExpensesTracker.Expenses.Expense

  action_fallback ExpensesTrackerWeb.FallbackController

  def index(conn, _params) do
    expenses = Expenses.list_expenses()
    render(conn, "index.json", expenses: expenses)
  end

  def create(conn, %{"expense" => expense_params}) do
    with {:ok, %Expense{} = expense} <- Expenses.create_expense(expense_params) do
      conn
      |> put_status(:created)
      |> render("show.json", expense: expense)
    end
  end

  def show(conn, %{"id" => id}) do
    expense = Expenses.get_expense!(id)
    render(conn, :show, expense: expense)
  end

  def update(conn, %{"id" => id, "expense" => expense_params}) do
    expense = Expenses.get_expense!(id)

    with {:ok, %Expense{} = expense} <- Expenses.update_expense(expense, expense_params) do
      render(conn, :show, expense: expense)
    end
  end

  def delete(conn, %{"id" => id}) do
    expense = Expenses.get_expense!(id)

    with {:ok, %Expense{}} <- Expenses.delete_expense(expense) do
      send_resp(conn, :no_content, "")
    end
  end
end
