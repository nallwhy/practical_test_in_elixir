defmodule PragTest.Accounts.User do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  alias PragTest.Repo

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:status, :string, default: "normal")
    field(:deleted_at, :utc_datetime_usec)
  end

  @required_create [:email]
  @optional_create [:name]

  defp changeset_create(%__MODULE__{} = struct, attrs) do
    struct
    |> cast(attrs, @required_create ++ @optional_create)
    |> validate_required(@required_create)
    |> validate_email()
    |> validate_name()
    |> unique_constraint(:email)
  end

  @required_update []
  @optional_update [:status, :deleted_at]

  defp changeset_update(%__MODULE__{} = struct, attrs) do
    struct
    |> cast(attrs, @required_update ++ @optional_update)
    |> validate_required(@required_update)
    |> check_constraint(:status, name: :status_deleted)
  end

  defp validate_email(changeset) do
    changeset
    |> validate_change(:email, fn _, email ->
      case Regex.match?(~r/^[^@]+@[^\.]+\..+$/, email) do
        false -> [email: "is invalid"]
        true -> []
      end
    end)
  end

  defp validate_name(changeset) do
    changeset |> validate_length(:name, max: 20)
  end

  def get(id) do
    __MODULE__
    |> where([u], u.status != "deleted")
    |> Repo.get(id)
  end

  def create(attrs) do
    %__MODULE__{}
    |> changeset_create(attrs)
    |> Repo.insert()
  end

  def update(%__MODULE__{} = user, attrs) do
    user
    |> changeset_update(attrs)
    |> Repo.update()
  end
end
