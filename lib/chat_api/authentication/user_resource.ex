defmodule ChatApi.Authentication.UserResource do
  @moduledoc """
  The UserResource model.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias ChatApi.Authentication.User

  @required_fields ~w(user_id user_resource_id user_resource_type)a

  schema "user_resources" do
    field(:user_resource_id, :string)
    field(:user_resource_type, :string)

    belongs_to(:user, User, foreign_key: :user_id)

    timestamps(inserted_at: :created_at)
  end

  def changeset(user_resource, attrs) do
    user_resource
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
