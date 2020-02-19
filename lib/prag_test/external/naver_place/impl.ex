defmodule PragTest.External.NaverPlace.Impl do
  alias PragTest.External.NaverPlace
  @behaviour NaverPlace

  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://store.naver.com/")

  @impl NaverPlace
  def crawl_store(pid) do
    with {:ok, %{status: 200, body: body}} <- do_request(pid),
         {:ok, data} <- parse_result(body, pid) do
      {:ok, data}
    else
      _ -> :error
    end
  end

  defp parse_result(body, pid) do
    with %{"raw_json" => raw_json} when not is_nil(raw_json) <-
           Regex.named_captures(~r|<script>window\.PLACE_STATE=(?<raw_json>.*?)</script>|, body),
         {:ok, json} <- raw_json |> Jason.decode(),
         base when not is_nil(base) <- json |> get_in(["business", pid, "base"]) do
      {:ok,
       %{
         name: parse_name(base),
         address: parse_address(base),
         phone: parse_phone(base)
       }}
    else
      _ -> :error
    end
  end

  defp parse_name(base), do: base |> Map.get("name")

  defp parse_address(base) do
    base |> Map.get("fullRoadAddr") || base |> Map.get("addr")
  end

  defp parse_phone(base), do: base |> Map.get("phone")

  def do_request(pid) do
    get("/restaurants/detail?id=#{pid}")
  end
end
