defmodule PragTest.Factory do
  use ExMachina.Ecto, repo: PragTest.Repo

  alias PragTest.Accounts.{User, Credential}

  def user_factory(attrs) do
    {status, attrs} = attrs |> Map.pop(:status, "normal")

    %User{
      email: sequence(:user_email, &"email-#{&1}@email.com"),
      name: sequence(:user_name, &"name-#{&1}")
    }
    |> apply_status(status)
    |> merge_attributes(attrs)
  end

  def credential_factory(attrs) do
    {user, attrs} = attrs |> Map.pop(:user, build(:user))
    # 간혹 미리 insert 가 필요한 경우 Map.pop_lazy/3 사용

    %Credential{
      user: user,
      type: sequence(:credential_type, ["email", "facebook"])
    }
    |> merge_attributes(attrs)
  end

  def add_credential(%User{} = user, attrs) do
    insert(:credential, attrs |> Map.put(:user, user))
  end

  defp apply_status(%User{} = user, "deleted" = status) do
    %User{user | status: status, deleted_at: DateTime.utc_now()}
  end

  defp apply_status(%User{} = user, status) do
    %User{user | status: status}
  end
end
