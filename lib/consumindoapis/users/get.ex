defmodule Consumindoapis.Users.Get do
  alias Consumindoapis.{User, Repo}

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, "user not found"}
      user -> {:ok, user}
    end
  end
end
