defmodule PragTest.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :user_id, references(:users), null: false
      add :type, :string, null: false
    end
  end
end
