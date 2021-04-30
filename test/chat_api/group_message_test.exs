defmodule ChatApi.GroupMessageTest do
  use ChatApi.DataCase

  alias ChatApi.Chat.{GroupMessage}

  import ChatApi.Factory

  @create_attrs %{message: "some body"}
  @invalid_attrs %{message: nil}

  setup do
    user = insert(:user)
    group = insert(:group)
    insert(:group_message, group: group)

    {:ok, jwt, _full_claims} = ChatApiWeb.Guardian.encode_and_sign(user)
    {:ok, %{user: user, group: group, jwt: jwt}}
  end

  test "list_group_messages/1 returns first 10 messages by default if no limit and offset are provided" do
    groups = insert_list(12, :group_message)

    actual_group_ids =
      ChatApi.Chat.list_group_messages(%{"offset" => 1}) |> Enum.map(fn group -> group.id end)

    expected_group_ids = Enum.take(groups, 10) |> Enum.map(fn group -> group.id end)
    assert actual_group_ids == expected_group_ids
  end

  test "create_group_message/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = ChatApi.Chat.create_group_message(@invalid_attrs)
  end

  test "create_group_message/1 with valid data creates a group message", %{
    group: group,
    user: user
  } do
    create_group_message =
      Map.merge(@create_attrs, %{user_id: Integer.to_string(user.id), group_id: group.id})

    assert {:ok, %GroupMessage{} = group_message} =
             ChatApi.Chat.create_group_message(create_group_message)

    assert group_message.message == "some body"
  end
end
