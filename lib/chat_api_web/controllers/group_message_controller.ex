defmodule ChatApiWeb.GroupMessageController do
  use ChatApiWeb, :controller
  use ChatApiWeb.GuardedController

  alias ChatApi.Chat.{GroupMessage}
  alias ChatApi.Authentication.{UserResource}

  action_fallback(ChatApiWeb.FallbackController)

  plug(
    Guardian.Plug.EnsureAuthenticated
    when action in [:create, :show]
  )

  def create(conn, %{"group_message" => params}, user) do
    with {:ok, %GroupMessage{} = group_message} <-
           ChatApi.Chat.create_group_message(params, user.id) do

      create_message_resource(user, group_message)

      conn
      |> put_status(:created)
      |> put_resp_header("location", group_message_path(conn, :show, group_message))
      |> render("show.json", group_message: group_message)
    end
  end

  def show(conn, %{"id" => id}, _) do
    group_message =
      id
      |> ChatApi.Chat.get_group_message()

    render(conn, "show.json", group_message: group_message)
  end

  defp create_message_resource(user, group_message) do
    user_resource_params = %{
      user_id: user.id,
      user_resource_id: Integer.to_string(group_message.id),
      user_resource_type: "group_message"
    }

    ChatApi.Authentication.Users.create_user_resource(user_resource_params)
  end
end
