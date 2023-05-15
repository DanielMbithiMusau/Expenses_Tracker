defmodule ExpensesTracker.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :integer
      add :paid_to, :string
      add :expense_type_id, references(:expense_types, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:expenses, [:expense_type_id])
  end
end
