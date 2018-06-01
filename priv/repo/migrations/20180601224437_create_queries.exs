defmodule Queryhub.Repo.Migrations.CreateQueries do
  use Ecto.Migration

  def change do
    create table(:queries) do
      add(:name, :string)
      add(:query, :string)
      add(:description, :string)
      add(:osquery_version, :string)
      add(:launcher_version, :string)

      timestamps()
    end
  end
end
