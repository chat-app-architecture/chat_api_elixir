defmodule ChatApi.Authentication.Users do
  @moduledoc """
  The boundry for the Users and UserResources system
  """

  alias ChatApi.Repo
  alias ChatApi.Authentication.{User, UserResource}

  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a update user.

  ## Examples

      iex> update_user(%{field: value})
      {:ok, %GroupMessage{}}

      iex> update_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def update_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> ChatApi.Authentication.Auth.hash_password()
    |> Repo.update()
  end

  @doc """
  Creates a user resource.

  ## Examples

      iex> create_user_resource(%{field: value})
      {:ok, %GroupMessage{}}

      iex> create_user_resource(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_resource(attrs) do
    %UserResource{}
    |> UserResource.changeset(attrs)
    |> Repo.insert()
  end
end
