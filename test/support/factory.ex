defmodule PragTest.Factory do
  use ExMachina.Ecto, repo: PragTest.Repo

  alias PragTest.Accounts.{User, Credential}

  def user_factory() do
    %User{
      email: sequence(:user_email, &"email-#{&1}@email.com"),
      name: sequence(:user_name, &"name-#{&1}")
    }
  end

  def credential_factory() do
    %Credential{
      user: build(:user),
      type: sequence(:credential_type, ["email", "facebook"])
    }
  end
end
