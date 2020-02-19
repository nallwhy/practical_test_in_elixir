defmodule PragTest.Accounts do
  alias PragTest.Accounts.User

  def update_user(id, attrs) do
    with %User{} = user <- User.get(id),
         {:ok, updated_user} <- User.update(user, attrs) do
      {:ok, updated_user}
    else
      _ -> {:error, :unknown_error}
    end
  end
end
