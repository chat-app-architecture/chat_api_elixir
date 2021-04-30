defmodule ChatApi.Authentication.AuthTest do
  @moduledoc false
  use ChatApi.DataCase

  alias ChatApi.Authentication.Auth

  @user_create_attrs %{
    email: "some email",
    password: "some password"
  }

  describe "given valid parameters" do
    test "register/1 creates a user" do
      Auth.register(@user_create_attrs)
    end
  end

  describe "given invalid parameters" do
    test "register/1 does not create a user" do
      Auth.register(%{})
      assert {:error, _} = Auth.register(%{})
    end

    test "register/1 returns error if email is used already" do
      Auth.register(@user_create_attrs)
      assert {:error, _} = Auth.register(@user_create_attrs)
    end
  end
end
