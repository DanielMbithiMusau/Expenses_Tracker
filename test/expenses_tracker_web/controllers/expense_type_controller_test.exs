defmodule ExpensesTrackerWeb.ExpenseTypeControllerTest do
  use ExpensesTrackerWeb.ConnCase

  import ExpensesTracker.ExpenseTypesFixtures

  alias ExpensesTracker.ExpenseTypes.ExpenseType

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all expense_types", %{conn: conn} do
      conn = get(conn, ~p"/api/expense_types")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create expense_type" do
    test "renders expense_type when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/expense_types", expense_type: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/expense_types/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/expense_types", expense_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update expense_type" do
    setup [:create_expense_type]

    test "renders expense_type when data is valid", %{conn: conn, expense_type: %ExpenseType{id: id} = expense_type} do
      conn = put(conn, ~p"/api/expense_types/#{expense_type}", expense_type: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/expense_types/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, expense_type: expense_type} do
      conn = put(conn, ~p"/api/expense_types/#{expense_type}", expense_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete expense_type" do
    setup [:create_expense_type]

    test "deletes chosen expense_type", %{conn: conn, expense_type: expense_type} do
      conn = delete(conn, ~p"/api/expense_types/#{expense_type}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/expense_types/#{expense_type}")
      end
    end
  end

  defp create_expense_type(_) do
    expense_type = expense_type_fixture()
    %{expense_type: expense_type}
  end
end
