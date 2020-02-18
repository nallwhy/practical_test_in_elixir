import Config

config :prag_test, PragTest.Repo,
  database: "prag_test_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
