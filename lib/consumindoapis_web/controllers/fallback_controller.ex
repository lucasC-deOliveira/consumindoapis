defmodule ConsumindoapisWeb.FallbackController do
  use ConsumindoapisWeb, :controller

  alias Consumindoapis.Error
  alias ConsumindoapisWeb.ErrorView

  def call(connection, {:error, %Error{status: status, result: result}}) do
    connection
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end

  def call(connection, {:error, reason}) do
    connection
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", result: reason)
  end
end
