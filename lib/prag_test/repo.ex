defmodule PragTest.Repo do
  use Ecto.Repo,
    otp_app: :prag_test,
    adapter: Ecto.Adapters.Postgres
end
