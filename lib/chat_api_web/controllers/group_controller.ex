defmodule ChatApiWeb.GroupController do
  use ChatApiWeb, :controller
  use ChatApiWeb.GuardedController

  alias ChatApi.{Chat, Repo}
  alias ChatApi.Chat.{Group}

  action_fallback(ChatApiWeb.FallbackController)

  plug(
    Guardian.Plug.EnsureAuthenticated
    when action in [
           :create,
           :update,
           :delete,
           :index
         ]
  )

  def index(conn, params, user) do
    groups =
      ChatApi.Chat.list_groups(params)
      |> Repo.preload([:group_messages])

    render(conn, "index.json", groups: groups)
  end

  def create(conn, %{"group" => params}, user) do
    with {:ok, %Group{} = group} <- ChatApi.Chat.create_group(params) do
      group =
        group
        |> Repo.preload([:group_messages])

      conn
      |> put_status(:created)
      |> put_resp_header("location", group_path(conn, :show, group))
      |> render("show.json", group: group)
    end
  end

  def show(conn, %{"id" => id}, user) do
    group =
      id
      |> ChatApi.Chat.get_group()
      |> Repo.preload([:group_messages])

    render(conn, "show.json", group: group)
  end

  def update(conn, %{"id" => id, "group" => group_params}, user) do
    group =
      id
      |> ChatApi.Chat.get_group()
      |> Repo.preload([:group_messages])

    with {:ok, %Group{} = group} <- ChatApi.Chat.update_group(group, group_params) do
      render(conn, "show.json", group: group)
    end
  end

  def delete(conn, %{"id" => id}, _user) do
    ChatApi.Chat.delete_group(id)
    send_resp(conn, :no_content, "")
  end
end
