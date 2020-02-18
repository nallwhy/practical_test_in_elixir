import Config

# Print only warnings and errors during test
config :logger, level: :warn

config :prag_test, PragTest.Repo,
  database: "prag_test_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
