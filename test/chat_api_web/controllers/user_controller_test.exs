defmodule ChatApiWeb.UserControllerTest do
  @moduledoc false
  use ChatApiWeb.ConnCase

  @user_default_attrs %{
    email: "john@jacob.com",
    password: "some password"
  }
  @user_create_attrs %{
    email: "john@jacob.com",
    password: "some password"
  }
  @user_update_attrs %{email: "john11@jacob.com"}

  def fixture(:user) do
    {:ok, user} = ChatApi.Authentication.Auth.register(@user_default_attrs)
    user
  end

  def secure_conn(conn) do
    user = fixture(:user)
    {:ok, jwt, _} = user |> ChatApiWeb.Guardian.encode_and_sign(%{}, token_type: :token)

    conn
    |> put_req_header("accept", "application/json")
    |> put_req_header("authorization", "Token " <> jwt)
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates user and renders user when data is valid", %{conn: conn} do
    conn = post(conn, user_path(conn, :create), user: @user_create_attrs)
    json = json_response(conn, 201)["user"]

    assert json == %{
             "id" => json["id"],
             "email" => "john@jacob.com",
             "token" => json["token"],
             "createdAt" => json["createdAt"],
             "updatedAt" => json["updatedAt"]
           }
  end

  test "view current_user data", %{conn: conn} do
    conn = get(secure_conn(conn), user_path(conn, :current_user))
    json = json_response(conn, 200)["user"]

    assert json == %{
             "id" => json["id"],
             "email" => @user_default_attrs.email,
             "token" => json["token"],
             "createdAt" => json["createdAt"],
             "updatedAt" => json["updatedAt"]
           }
  end

  test "update current_user data", %{conn: conn} do
    conn = put(secure_conn(conn), user_path(conn, :update), user: @user_update_attrs)
    json = json_response(conn, 200)["user"]

    assert json == %{
             "id" => json["id"],
             "email" => @user_update_attrs.email,
             "token" => json["token"],
             "createdAt" => json["createdAt"],
             "updatedAt" => json["updatedAt"]
           }
  end
end
