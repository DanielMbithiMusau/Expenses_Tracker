defmodule ExpensesTrackerWeb.ExpenseTypeController do
  use ExpensesTrackerWeb, :controller

  alias ExpensesTracker.ExpenseTypes
  alias ExpensesTracker.ExpenseTypes.ExpenseType

  action_fallback ExpensesTrackerWeb.FallbackController

  def index(conn, _params) do
    expense_types = ExpenseTypes.list_expense_types()
    render(conn, "index.json", expense_types: expense_types)
  end

  def create(conn, %{"expense_type" => expense_type_params}) do
    with {:ok, %ExpenseType{} = expense_type} <- ExpenseTypes.create_expense_type(expense_type_params) do
      conn
      |> put_status(:created)
      |> render("show.json", expense_type: expense_type)
    end
  end

  def show(conn, %{"id" => id}) do
    expense_type = ExpenseTypes.get_expense_type!(id)
    render(conn, :show, expense_type: expense_type)
  end

  def update(conn, %{"id" => id, "expense_type" => expense_type_params}) do
    expense_type = ExpenseTypes.get_expense_type!(id)

    with {:ok, %ExpenseType{} = expense_type} <- ExpenseTypes.update_expense_type(expense_type, expense_type_params) do
      render(conn, :show, expense_type: expense_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    expense_type = ExpenseTypes.get_expense_type!(id)

    with {:ok, %ExpenseType{}} <- ExpenseTypes.delete_expense_type(expense_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
