defmodule ConsumindoapisWeb.RepositoriesController do
  use ConsumindoapisWeb, :controller

  alias ConsumindoapisWeb.FallbackController

  action_fallback FallbackController

  def show(connection, %{"username" => username}) do
    with {:ok, [_ | _] = repositories} <- Consumindoapis.get_all_repositories(username) do
      connection
      |> put_status(:ok)
      |> render("show.json", repositories: repositories)
    end
  end
end
