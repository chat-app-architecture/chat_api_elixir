defmodule ChatApi.Repo.Migrations.CreateGroupMessagesTable do
  use Ecto.Migration

  def change do
    create table(:group_messages) do
      add(:message, :string)
      add(:user_id, :string)

      add(:group_id, references(:groups))

      timestamps(inserted_at: :created_at)
    end

    create(unique_index(:group_messages, [:group_id, :user_id]))
  end
end
