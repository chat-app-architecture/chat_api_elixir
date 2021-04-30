defmodule ChatApiWeb.GroupControllerTest do
  use ChatApiWeb.ConnCase

  import ChatApi.Factory

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  setup do
    user = insert(:user)
    group = insert(:group)

    {:ok, jwt, _full_claims} = ChatApiWeb.Guardian.encode_and_sign(user)
    {:ok, %{group: group, user: user, jwt: jwt}}
  end

  test "lists all entries on index", %{conn: conn, jwt: jwt} do
    group = insert(:group)
    insert(:group_message, group: group)

    conn = conn |> put_req_header("authorization", "Token #{jwt}")
    conn = get(conn, group_path(conn, :index))
    assert json_response(conn, 200)["groups"] != []
  end

  test "creates group and renders group when data is valid", %{conn: conn, jwt: jwt} do
    conn = conn |> put_req_header("authorization", "Token #{jwt}")
    conn = post(conn, group_path(conn, :create), group: @create_attrs)
    json = json_response(conn, 201)["group"]

    assert json == %{
             "id" => json["id"],
             "name" => json["name"],
             "createdAt" => json["createdAt"],
             "updatedAt" => json["updatedAt"]
           }
  end

  test "does not create group and renders errors when data is invalid", %{conn: conn, jwt: jwt} do
    conn = conn |> put_req_header("authorization", "Token #{jwt}")
    conn = post(conn, group_path(conn, :create), group: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen group and renders group when data is valid", %{
    conn: conn,
    jwt: jwt,
    group: group
  } do
    group_id = group.id
    conn = conn |> put_req_header("authorization", "Token #{jwt}")
    conn = put(conn, group_path(conn, :update, group), group: @update_attrs)
    assert %{"id" => ^group_id} = json_response(conn, 200)["group"]

    conn = get(conn, group_path(conn, :show, group_id))
    json = json_response(conn, 200)["group"]

    assert json == %{
             "id" => group_id,
             "name" => json["name"],
             "createdAt" => json["createdAt"],
             "updatedAt" => json["updatedAt"]
           }
  end

  test "does not update chosen group and renders errors when data is invalid", %{
    conn: conn,
    jwt: jwt,
    group: group
  } do
    conn = conn |> put_req_header("authorization", "Token #{jwt}")
    conn = put(conn, group_path(conn, :update, group), group: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end
end
