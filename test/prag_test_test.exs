defmodule PragTestTest do
  use ExUnit.Case
  doctest PragTest

  test "greets the world" do
    assert PragTest.hello() == :world
  end
end
