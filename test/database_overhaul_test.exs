defmodule DatabaseOverhaulTest do
  use ExUnit.Case
  doctest DatabaseOverhaul

  test "greets the world" do
    assert DatabaseOverhaul.hello() == :world
  end
end
