defmodule PragTest.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import PragTest.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PragTest.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(PragTest.Repo, {:shared, self()})
    end

    :ok
  end
end
