defmodule PragTest.Stores.Store do
  use Ecto.Schema
  import Ecto.Changeset
  alias PragTest.Repo

  schema "stores" do
    field(:name, :string)
    field(:address, :string)
    field(:phone, :string)
  end

  @required_create [:name, :address, :phone]
  @optional_create []

  defp changeset_create(%__MODULE__{} = struct, attrs) do
    struct
    |> cast(attrs, @required_create ++ @optional_create)
    |> validate_required(@required_create)
  end

  def create(attrs) do
    %__MODULE__{}
    |> changeset_create(attrs)
    |> Repo.insert()
  end
end
