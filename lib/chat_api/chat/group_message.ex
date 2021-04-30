defmodule ChatApi.Chat.GroupMessage do
  @moduledoc """
  The GroupMessage Model
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias ChatApi.Authentication.User
  alias ChatApi.Chat.{Group, GroupMessage}

  @timestamps_opts [type: :utc_datetime]
  @required_fields ~w(message user_id group_id)a

  schema "group_messages" do
    field(:message, :string)
    field(:user_id, :string)

    belongs_to(:group, Group, foreign_key: :group_id)

    timestamps(inserted_at: :created_at)
  end

  def changeset(%GroupMessage{} = group_message, attrs) do
    group_message
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:group)
  end
end
