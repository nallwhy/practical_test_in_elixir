defmodule PragTest.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute(
      "CREATE TYPE user_status AS ENUM('normal', 'deleted')",
      "DROP TYPE user_status"
    )

    create table(:users) do
      add(:email, :string, null: false)
      add(:name, :string, null: true)
      add(:status, :user_status, null: false, default: "normal")
      add(:deleted_at, :utc_datetime, null: true)
    end

    create unique_index(:users, [:email])
    create constraint(:users, :status_deleted, check: "(status = 'deleted') = (deleted_at IS NOT NULL)")
  end
end
