defmodule ExpensesTracker.Repo.Migrations.CreateExpenseTypes do
  use Ecto.Migration

  def change do
    create table(:expense_types, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string

      timestamps()
    end
  end
end
