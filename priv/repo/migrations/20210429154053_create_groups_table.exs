defmodule ChatApi.Repo.Migrations.CreateGroupsTable do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add(:name, :string)

      timestamps(inserted_at: :created_at)
    end

    create(unique_index(:groups, [:name]))
  end
end
