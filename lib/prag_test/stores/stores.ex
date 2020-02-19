defmodule PragTest.Stores do
  alias PragTest.Stores.Store

  @naver_place_crawler Application.get_env(:prag_test, :naver_place_crawler)

  def crawl_and_save_store(source, pid) do
    with {:ok, attrs} <- get_crawler_module(source).crawl_store(pid),
         {:ok, store} <- Store.create(attrs) do
      {:ok, store}
    else
      _ -> {:error, :unknown_error}
    end
  end

  defp get_crawler_module(source) do
    case source do
      "naver_place" -> @naver_place_crawler
    end
  end
end
