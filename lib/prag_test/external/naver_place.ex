defmodule PragTest.External.NaverPlace do
  @callback crawl_store(pid :: binary()) :: {:ok, atom()} | :error
end
