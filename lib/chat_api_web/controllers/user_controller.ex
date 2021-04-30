defmodule ChatApiWeb.UserController do
  use ChatApiWeb, :controller
  use ChatApiWeb.GuardedController

  alias ChatApi.Authentication.{Auth, Users}

  action_fallback(ChatApiWeb.FallbackController)

  plug(Guardian.Plug.EnsureAuthenticated when action in [:current_user, :update])

  def create(conn, %{"user" => user_params}, _) do
    case Auth.register(user_params) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} =
          user |> ChatApiWeb.Guardian.encode_and_sign(%{}, token_type: :token)

        conn
        |> put_status(:created)
        |> render("show.json", jwt: jwt, user: user)

      {:error, changeset} ->
        render(conn, ChatApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def current_user(conn, _params, user) do
    jwt = ChatApiWeb.Guardian.Plug.current_token(conn)

    if user != nil do
      render(conn, "show.json", jwt: jwt, user: user)
    else
      conn
      |> put_status(:not_found)
      |> render(ChatApiWeb.ErrorView, "404.json", [])
    end

    conn
    |> put_status(:ok)
    |> render("show.json", jwt: jwt, user: user)
  end

  def update(conn, %{"user" => user_params}, user) do
    jwt = ChatApiWeb.Guardian.Plug.current_token(conn)

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        render(conn, "show.json", jwt: jwt, user: user)

      {:error, changeset} ->
        render(conn, ChatApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
