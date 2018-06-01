defmodule Queryhub.OsqueryTest do
  use Queryhub.DataCase

  alias Queryhub.Osquery

  describe "queries" do
    alias Queryhub.Osquery.Query

    @valid_attrs %{
      description: "some description",
      launcher_version: "some launcher_version",
      name: "some name",
      osquery_version: "some osquery_version",
      query: "some query"
    }
    @update_attrs %{
      description: "some updated description",
      launcher_version: "some updated launcher_version",
      name: "some updated name",
      osquery_version: "some updated osquery_version",
      query: "some updated query"
    }
    @invalid_attrs %{
      description: nil,
      launcher_version: nil,
      name: nil,
      osquery_version: nil,
      query: nil
    }

    def query_fixture(attrs \\ %{}) do
      {:ok, query} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Osquery.create_query()

      query
    end

    test "list_queries/0 returns all queries" do
      query = query_fixture()
      assert Osquery.list_queries() == [query]
    end

    test "get_query!/1 returns the query with given id" do
      query = query_fixture()
      assert Osquery.get_query!(query.id) == query
    end

    test "create_query/1 with valid data creates a query" do
      assert {:ok, %Query{} = query} = Osquery.create_query(@valid_attrs)
      assert query.description == "some description"
      assert query.launcher_version == "some launcher_version"
      assert query.name == "some name"
      assert query.osquery_version == "some osquery_version"
      assert query.query == "some query"
    end

    test "create_query/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Osquery.create_query(@invalid_attrs)
    end

    test "update_query/2 with valid data updates the query" do
      query = query_fixture()
      assert {:ok, query} = Osquery.update_query(query, @update_attrs)
      assert %Query{} = query
      assert query.description == "some updated description"
      assert query.launcher_version == "some updated launcher_version"
      assert query.name == "some updated name"
      assert query.osquery_version == "some updated osquery_version"
      assert query.query == "some updated query"
    end

    test "update_query/2 with invalid data returns error changeset" do
      query = query_fixture()
      assert {:error, %Ecto.Changeset{}} = Osquery.update_query(query, @invalid_attrs)
      assert query == Osquery.get_query!(query.id)
    end

    test "delete_query/1 deletes the query" do
      query = query_fixture()
      assert {:ok, %Query{}} = Osquery.delete_query(query)
      assert_raise Ecto.NoResultsError, fn -> Osquery.get_query!(query.id) end
    end

    test "change_query/1 returns a query changeset" do
      query = query_fixture()
      assert %Ecto.Changeset{} = Osquery.change_query(query)
    end
  end
end
