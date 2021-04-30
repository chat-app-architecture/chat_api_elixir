defmodule ChatApi.Chat do
  @moduledoc """
  The boundary for the Chat system.
  """

  import Ecto.Query, warn: false
  alias ChatApi.Repo
  alias ChatApi.Authentication.{User, UserResource}
  alias ChatApi.Chat.{Group, GroupMessage}

  @default_pagination_limit 10

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups(%{"limit" => 10, "offset" => 0})
      [%GroupMessage{}, ...]

  """
  def list_groups(params) do
    limit = params["limit"] || @default_pagination_limit
    offset = params["offset"] || 1

    from(a in Group, limit: ^limit, offset: ^offset, order_by: a.created_at)
    |> Repo.all()
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group(123)
      %Article{}

      iex> get_group(456)
      ** (Ecto.NoResultsError)

  """
  def get_group(id), do: Repo.get!(Group, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns the list of group messages.

  ## Examples

      iex> list_group_messages(%{"limit" => 10, "offset" => 0})
      [%GroupMessage{}, ...]

  """
  def list_group_messages(params) do
    limit = params["limit"] || @default_pagination_limit
    offset = params["offset"] || 1

    from(a in GroupMessage, limit: ^limit, offset: ^offset, order_by: a.created_at)
    |> Repo.all()
  end

  @doc """
  Creates a group message.

  ## Examples

      iex> create_group_message(%{field: value})
      {:ok, %GroupMessage{}}

      iex> create_group_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group_message(attrs \\ %{}, user_id \\ "") do
    group_message =
      %GroupMessage{}
      |> GroupMessage.changeset(attrs)
      |> Repo.insert()
  end
end
