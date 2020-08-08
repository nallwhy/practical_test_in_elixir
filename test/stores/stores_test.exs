defmodule PragTest.Stores.StoreTest do
  use PragTest.DataCase
  import Hammox
  alias PragTest.Stores
  alias PragTest.Stores.Store

  describe "crawl_and_save_store/2" do
    @attrs %{
      name: "제일",
      phone: "02-497-0918",
      address: "서울특별시 성동구 왕십리로10길 9-9 1층 제일"
    }

    test "with valid source and pid" do
      defmock(PragTest.External.NaverPlace.Mock, for: PragTest.External.NaverPlace)

      expect(PragTest.External.NaverPlace.Mock, :crawl_store, fn "12345" ->
        {:ok, @attrs}
      end)

      assert {:ok, %Store{} = store} = Stores.crawl_and_save_store("naver_place", "12345")
      assert store.name == @attrs.name
      assert store.phone == @attrs.phone
      assert store.address == @attrs.address
    end
  end
end
