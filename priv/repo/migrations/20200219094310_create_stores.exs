defmodule PragTest.Repo.Migrations.CreateStores do
  use Ecto.Migration

  def change do
    create table(:stores) do
      add(:name, :string, null: false)
      add(:address, :string, null: false)
      add(:phone, :string, null: false)
    end
  end
end
