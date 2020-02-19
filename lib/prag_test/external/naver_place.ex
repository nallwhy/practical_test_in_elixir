defmodule PragTest.External.NaverPlace do
  @callback crawl_store(pid :: binary()) :: {:ok, map()} | :error
end
