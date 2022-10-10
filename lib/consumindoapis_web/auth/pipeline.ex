defmodule ConsumindoapisWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :consumindoapis

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
