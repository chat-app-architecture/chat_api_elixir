defmodule ChatApiWeb.GroupMessageControllerTest do
  use ChatApiWeb.ConnCase

  import ChatApi.Factory

  @create_attrs %{message: "some name"}
  @update_attrs %{message: "some updated name"}
  @invalid_attrs %{message: nil}

  setup do
    user = insert(:user)
    group = insert(:group)

    {:ok, jwt, _full_claims} = ChatApiWeb.Guardian.encode_and_sign(user)
    {:ok, %{group: group, user: user, jwt: jwt}}
  end

  test "creates group message and renders group message when data is valid", %{
    conn: conn,
    jwt: jwt,
    group: group,
    user: user
  } do
    conn = conn |> put_req_header("authorization", "Token #{jwt}")

    group_message =
      Map.merge(@create_attrs, %{"group_id" => group.id, "user_id" => Integer.to_string(user.id)})

    conn = post(conn, group_message_path(conn, :create), group_message: group_message)
    json = json_response(conn, 201)["group_message"]

    assert json == %{
             "id" => json["id"],
             "message" => json["message"],
             "userId" => json["userId"],
             "groupId" => json["groupId"]
           }
  end
end
