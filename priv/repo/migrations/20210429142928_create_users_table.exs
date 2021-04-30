defmodule ChatApi.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string)
      add(:password, :string)

      timestamps(inserted_at: :created_at)
    end

    create(unique_index(:users, [:email]))
  end
end
