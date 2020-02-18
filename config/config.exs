import Config

config :prag_test,
  ecto_repos: [PragTest.Repo]

import_config "#{Mix.env()}.exs"
