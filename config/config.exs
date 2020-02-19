import Config

config :prag_test,
  ecto_repos: [PragTest.Repo]

config :tesla, adapter: Tesla.Adapter.Hackney

config :prag_test, naver_place_crawler: PragTest.External.NaverPlace.Impl

import_config "#{Mix.env()}.exs"
