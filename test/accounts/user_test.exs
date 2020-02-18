defmodule PragTest.Accounts.UserTest do
  use PragTest.DataCase
  import Ecto.Changeset
  alias PragTest.Accounts.User
  alias PragTest.Repo

  describe "get/1" do
    @attrs %{
      email: "json@rinobr.com",
      name: "json"
    }

    setup do
      user = insert_user(@attrs)

      %{user: user}
    end

    test "with exist id returns ok", %{user: user} do
      assert %User{} = existing_user = User.get(user.id)
      assert existing_user.email == user.email
      assert existing_user.name == user.name
    end

    test "with not exsiting id returns ok" do
      assert User.get(-1) == nil
    end
  end

  describe "create/1" do
    @attrs %{
      email: "json@rinobr.com",
      name: nil
    }

    test "with valid attrs (w/o name) returns ok" do
      assert {:ok, %User{} = user} = User.create(@attrs)
      assert user.email == @attrs.email
      assert user.name == @attrs.name
    end

    test "with valid attrs (w/ name) returns ok" do
      name = "json"
      assert {:ok, %User{} = user} = User.create(%{@attrs | name: name})
      assert user.email == @attrs.email
      assert user.name == name
    end

    test "without email returns error" do
      assert {:error, %Ecto.Changeset{errors: errors}} = User.create(%{@attrs | email: nil})

      assert {"can't be blank", _} = errors[:email]
    end

    test "with invalid email returns error" do
      assert {:error, %Ecto.Changeset{errors: errors}} =
               User.create(%{@attrs | email: "rinobr.com"})

      assert {"is invalid", _} = errors[:email]
    end

    test "with duplicated email returns error" do
      insert_user(@attrs)

      assert {:error, %Ecto.Changeset{errors: errors}} =
               User.create(%{email: @attrs.email, name: "not json"})

      assert {"has already been taken", _} = errors[:email]
    end

    test "with long name returns error" do
      assert {:error, %Ecto.Changeset{errors: errors}} =
               User.create(%{@attrs | name: String.duplicate("a", 21)})

      assert {"should be at most %{count} character(s)",
              [count: 20, validation: :length, kind: :max, type: :string]} = errors[:name]
    end
  end

  describe "update/2" do
    @attrs %{
      status: "deleted",
      deleted_at: DateTime.utc_now()
    }

    setup do
      user =
        insert_user(%{
          email: "json@rinobr.com",
          name: "json"
        })

      %{user: user}
    end

    test "with status (deleted) and deleted_at returns ok", %{user: user} do
      assert {:ok, %User{} = updated_user} = User.update(user, @attrs)
      assert updated_user.status == @attrs.status
      assert DateTime.compare(updated_user.deleted_at, @attrs.deleted_at) == :eq
    end

    test "with status (deleted) returns error", %{user: user} do
      assert {:error, %Ecto.Changeset{errors: errors}} =
               User.update(user, %{@attrs | deleted_at: nil})

      assert {"is invalid", _} = errors[:status]
    end

    test "with deleted_at returns error", %{user: user} do
      assert {:error, %Ecto.Changeset{errors: errors}} =
               User.update(user, %{@attrs | status: "normal"})

      assert {"is invalid", _} = errors[:status]
    end

    test "with already deleted user returns ok", %{user: user} do
      Repo.update(change(user, @attrs))

      assert {:ok, updated_user} = User.update(user, @attrs)
    end
  end

  defp insert_user(attrs) do
    Repo.insert!(struct(User, attrs))
  end
end
