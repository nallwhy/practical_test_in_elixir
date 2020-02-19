defmodule PragTest.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset
  alias PragTest.Repo
  alias PragTest.Accounts.User

  schema "credentials" do
    belongs_to(:user, User)

    field(:type, :string)
  end

  @required_create [:user_id, :type]
  @optional_create []

  defp changeset_create(%__MODULE__{} = struct, attrs) do
    struct
    |> cast(attrs, @required_create ++ @optional_create)
    |> validate_required(@required_create)
    |> validate_inclusion(:type, ["email", "facebook"])
    |> assoc_constraint(:user)
  end

  def get(id), do: __MODULE__ |> Repo.get(id)

  def create(attrs) do
    %__MODULE__{}
    |> changeset_create(attrs)
    |> Repo.insert()
  end
end
