defmodule ChatApi.Repo.Migrations.CreateUserResourcesTable do
  use Ecto.Migration

  def change do
    create table(:user_resources) do
      add(:user_resource_type, :string)
      add(:user_resource_id, :string)

      add(:user_id, references(:users))

      timestamps(inserted_at: :created_at)
    end

    create(unique_index(:user_resources, [:user_id, :user_resource_type]))
  end
end
