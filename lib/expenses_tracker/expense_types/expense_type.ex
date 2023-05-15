defmodule ExpensesTracker.ExpenseTypes.ExpenseType do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "expense_types" do
    field :name, :string

    has_many :expenses, ExpensesTracker.Expenses.Expense

    timestamps()
  end

  @doc false
  def changeset(expense_type, attrs) do
    expense_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
