defmodule Queryhub.Osquery.Query do
  use Ecto.Schema
  import Ecto.Changeset

  schema "queries" do
    field(:description, :string)
    field(:launcher_version, :string)
    field(:name, :string)
    field(:osquery_version, :string)
    field(:query, :string)

    timestamps()
  end

  @doc false
  def changeset(query, attrs) do
    query
    |> cast(attrs, [:name, :query, :description, :osquery_version, :launcher_version])
    |> validate_required([:name, :query, :description, :osquery_version, :launcher_version])
  end
end
