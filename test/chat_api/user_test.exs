defmodule ChatApi.Authentication.UserTest do
  @moduledoc nil

  use ChatApi.DataCase

  alias ChatApi.Authentication.Users

  @user_create_attrs %{
    email: "some email",
    password: "some password"
  }

  describe "given valid parameters" do
    test "update_user/2 hashes the password if new one set" do
      {:ok, user} = ChatApi.Authentication.Auth.register(@user_create_attrs)

      new_password = "newPassword!123"

      Users.update_user(user, %{password: new_password})

      assert ChatApi.Authentication.Auth.find_user_and_check_password(%{
               "user" => %{"email" => @user_create_attrs.email, "password" => new_password}
             })
    end
  end
end
