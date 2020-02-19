defmodule PragTest.Factory do
  alias PragTest.Accounts.{User, Credential}
  alias PragTest.Repo

  def build(:user) do
    %User{
      email: sequence(&"email-#{&1}@email.com"),
      name: sequence("user_name")
    }
  end

  def build(:credential) do
    %Credential{
      user: build(:user),
      type: ["email", "facebook"] |> Enum.random()
    }
  end

  def build(factory_name, attrs) do
    factory_name |> build() |> struct(attrs)
  end

  def insert(factory_name, attrs \\ %{})

  def insert(factory_name, attrs) when is_list(attrs) do
    insert(factory_name, Map.new(attrs))
  end

  def insert(factory_name, attrs) do
    factory_name |> build(attrs) |> Repo.insert!()
  end

  defp sequence(prefix) when is_binary(prefix) do
    "#{prefix}-#{System.unique_integer([:positive])}"
  end

  defp sequence(func) when is_function(func) do
    func.(System.unique_integer([:positive]))
  end
end
