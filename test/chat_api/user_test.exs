defmodule ChatApi.Authentication.UserTest do
  @moduledoc nil

  use ChatApi.DataCase

  @user_create_attrs %{
    email: "some email",
    password: "some password"
  }

  describe "given valid parameters" do
    test "get_user/1 retrieves a user" do
      {:ok, user} = ChatApi.Authentication.Auth.register(@user_create_attrs)

      get_user = ChatApi.Authentication.get_user!(user.id)

      assert get_user.id == user.id
    end
  end
end
