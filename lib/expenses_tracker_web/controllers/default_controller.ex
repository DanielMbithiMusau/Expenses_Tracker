defmodule ExpensesTrackerWeb.DefaultController do
  use ExpensesTrackerWeb, :controller

  def index(conn, _params) do
    text conn, "The Expenses Tracker API is working - #{Mix.env()}"
  end
end
