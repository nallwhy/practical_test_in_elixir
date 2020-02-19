defmodule PragTest.Accounts.CredentialTest do
  use PragTest.DataCase
  alias PragTest.Accounts.Credential

  describe "get/1" do
    setup do
      credential = insert(:credential)

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
      user = insert(:user)

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
end
