defmodule Consumindoapis.Github.Behavior do
  alias Consumindoapis.Error
  @typep client_result :: {:ok, list()} | {:error, Error.t()}

  @callback get_repositories(String.t()) :: client_result
end
