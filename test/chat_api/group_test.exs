defmodule ChatApi.GroupTest do
  use ChatApi.DataCase

  alias ChatApi.Chat.{Group}

  import ChatApi.Factory

  @create_attrs %{name: "some body"}
  @update_attrs %{name: "some updated body"}
  @invalid_attrs %{name: nil}

  setup do
    user = insert(:user)
    group = insert(:group)

    {:ok, jwt, _full_claims} = ChatApiWeb.Guardian.encode_and_sign(user)
    {:ok, %{user: user, group: group, jwt: jwt}}
  end

  @tag :without_group
  test "list_groups/1 returns first 10 groups by default if no limit and offset are provided" do
    groups = insert_list(12, :group)
    actual_group_ids = ChatApi.Chat.list_groups(%{}) |> Enum.map(fn group -> group.id end)
    expected_group_ids = Enum.take(groups, 10) |> Enum.map(fn group -> group.id end)
    assert actual_group_ids == expected_group_ids
  end

  @tag :without_group
  test "list_groups/1 returns group after particular offset" do
    groups = insert_list(3, :group)

    actual_group_ids =
      ChatApi.Chat.list_groups(%{"offset" => 2}) |> Enum.map(fn group -> group.id end)

    expected_group_ids = Enum.take(groups, -2) |> Enum.map(fn group -> group.id end)
    assert actual_group_ids == expected_group_ids
  end

  @tag :without_group
  test "list_groups/1 returns limited number of group after particular offset" do
    groups = insert_list(4, :group)

    actual_group_ids =
      ChatApi.Chat.list_groups(%{"offset" => 2, "limit" => "2"})
      |> Enum.map(fn group -> group.id end)

    expected_group_ids = [Enum.at(groups, 1).id, Enum.at(groups, 2).id]
    assert actual_group_ids == expected_group_ids
  end

  test "get_group! returns the group with given id", %{group: group} do
    assert ChatApi.Chat.get_group(group.id).id == group.id
  end

  test "create_group/1 with valid data creates a group" do
    assert {:ok, %Group{} = group} = ChatApi.Chat.create_group(@create_attrs)
    assert group.name == "some body"
  end

  test "create_group/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = ChatApi.Chat.create_group(@invalid_attrs)
  end

  test "update_group/2 with valid data updates the group", %{group: group} do
    assert {:ok, group} = ChatApi.Chat.update_group(group, @update_attrs)
    assert %Group{} = group

    assert group.name == "some updated body"
  end

  test "update_group/2 with invalid data returns error changeset", %{group: group} do
    assert {:error, %Ecto.Changeset{}} = ChatApi.Chat.update_group(group, @invalid_attrs)
    assert group.id == ChatApi.Chat.get_group(group.id).id
  end
end
