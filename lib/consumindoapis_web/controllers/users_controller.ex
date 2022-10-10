defmodule ConsumindoapisWeb.UserController do
  use ConsumindoapisWeb, :controller

  alias ConsumindoapisWeb.Auth.Guardian

  def create(conn, %{"password" => _password} = params) do
    with {:ok, user_id} <- Consumindoapis.Users.Create.call(params) do
      conn
      |> put_status(201)
      |> render("create.json", user_id: user_id)
    else
      {:error, reason} ->
        conn
        |> put_view(ConsumindoapisWeb.ErrorView)
        |> put_status(400)
        |> render("error.json", reason: reason)
    end
  end

  def login(conn, %{"password" => password, "id" => id} = _params) do
    with {:ok, token} <- Guardian.authenticate(id, password) do
      conn
      |> put_status(:ok)
      |> render("token.json", token: token)
    else
      {:error, %{status: status, message: message}} ->
        conn
        |> put_view(ConsumindoapisWeb.ErrorView)
        |> put_status(status)
        |> render("error.json", reason: message)
    end
  end
end
