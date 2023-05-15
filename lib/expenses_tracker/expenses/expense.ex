defmodule ExpensesTracker.Expenses.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "expenses" do
    field :amount, :integer
    field :paid_to, :string

    belongs_to :expense_type, ExpensesTracker.ExpenseTypes.ExpenseType

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:amount, :paid_to])
    |> validate_required([:amount, :paid_to])
  end
end
