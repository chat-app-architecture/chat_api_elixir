defmodule ChatApi.Authentication.User do
  @moduledoc """
  The User model.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias ChatApi.Authentication.UserResource

  @required_fields ~w(email password)a

  schema "users" do
    field(:email, :string, unique: true)
    field(:password, :string)

    has_many(:user_resources, UserResource)

    timestamps(inserted_at: :created_at)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
  end
end
