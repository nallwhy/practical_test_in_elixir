defmodule PragTest.Accounts.CredentialTest do
  use PragTest.DataCase
  alias PragTest.Accounts.{Credential, User}
  alias PragTest.Repo

  describe "get/1" do
    setup do
      user = insert_user(%{email: "json@rinobr.com"})
      credential = insert_credential(%{user_id: user.id, type: "email"})

      %{credential: credential}
    end

    test "with existing id returns ok", %{credential: credential} do
      assert %Credential{} = existing_credential = Credential.get(credential.id)
      assert existing_credential.id == credential.id
      assert existing_credential.type == credential.type
    end

    test "with not exsiting id returns error" do
      assert Credential.get(-1) == nil
    end
  end

  describe "create/1" do
    @attrs %{
      user_id: nil,
      type: "email"
    }

    setup do
      user = insert_user(%{email: "json@rinobr.com"})

      %{user: user}
    end

    test "with valid attrs returns ok", %{user: user} do
      assert {:ok, %Credential{} = credential} = Credential.create(%{@attrs | user_id: user.id})
      assert credential.user_id == user.id
      assert credential.type == @attrs.type
    end

    test "with not exsiting user_id returns error" do
      assert {:error, %Ecto.Changeset{errors: errors}} =
               Credential.create(%{@attrs | user_id: -1})

      assert {"does not exist", _} = errors[:user]
    end

    test "with invalid type returns error", %{user: user} do
      assert {:error, %Ecto.Changeset{errors: errors}} =
               Credential.create(%{@attrs | user_id: user.id, type: "invalid type"})

      assert {"is invalid", _} = errors[:type]
    end
  end

  defp insert_user(attrs) do
    Repo.insert!(struct(User, attrs))
  end

  defp insert_credential(attrs) do
    Repo.insert!(struct(Credential, attrs))
  end
end
