defmodule ExpensesTracker.Repo do
  use Ecto.Repo,
    otp_app: :expenses_tracker,
    adapter: Ecto.Adapters.Postgres
end
