defmodule ChatApi.Authentication.UserResourceTest do
  use ChatApi.DataCase

  import ChatApi.Factory

  setup do
    user = insert(:user)
    group = insert(:group)
    group_message = insert(:group_message, group: group)

    {:ok, jwt, _full_claims} = ChatApiWeb.Guardian.encode_and_sign(user)
    {:ok, %{user: user, group: group, group_message: group_message, jwt: jwt}}
  end

  test "creates a user resource", %{user: user, group_message: group_message} do
    user_resource_params = %{
      user_id: user.id,
      user_resource_id: Integer.to_string(group_message.id),
      user_resource_type: "group_message"
    }

    user_resource = ChatApi.Authentication.Users.create_user_resource(user_resource_params)
    assert %ChatApi.Authentication.UserResource{} = user_resource
  end
end
