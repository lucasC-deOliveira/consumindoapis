defmodule Consumindoapis.Github.Client do
  use Tesla

  alias Tesla.Env

  alias Consumindoapis.Error

  alias Consumindoapis.Github.Behavior

  @behaviour Behavior

  @base_url "https://api.github.com/users/"

  @base_url "https://api.github.com/users"
  @request_headers [{"user-agent", "Tesla"}]

  plug Tesla.Middleware.Headers, @request_headers
  plug Tesla.Middleware.JSON

  def get_repositories(url \\ @base_url, username) do
    "#{url}/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: []}}) do
    {:ok, [%{message: "User doesn't have any public repositories yet."}]}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    response =
      Enum.map(body, fn repo ->

        %{
          id: repo["id"],
          description: repo["description"],
          html_url: repo["html_url"],
          name: repo["name"],
          stargazers_count: repo["stargazers_count"]
        }
      end)

    {:ok, response}
  end

  defp handle_get({:ok, %Env{status: 403}}) do
    {:error, Error.build(:forbidden, "Request forbidden by administrative rules!")}
  end

  defp handle_get({:ok, %Env{status: 404}}) do
    {:error, Error.build(:not_found, "Page not found!")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
