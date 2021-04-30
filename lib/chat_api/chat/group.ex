defmodule ChatApi.Chat.Group do
  @moduledoc """
  The Group Model
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias ChatApi.Authentication.User
  alias ChatApi.Chat.{Group, GroupMessage}

  @timestamps_opts [type: :utc_datetime]
  @required_fields ~w(name)a

  schema "groups" do
    field(:name, :string)

    has_many(:group_messages, GroupMessage)

    timestamps(inserted_at: :created_at)
  end

  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
