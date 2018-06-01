defmodule QueryhubWeb.QueryControllerTest do
  use QueryhubWeb.ConnCase

  alias Queryhub.Osquery

  @create_attrs %{
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

  def fixture(:query) do
    {:ok, query} = Osquery.create_query(@create_attrs)
    query
  end

  describe "index" do
    test "lists all queries", %{conn: conn} do
      conn = get(conn, query_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Queries"
    end
  end

  describe "new query" do
    test "renders form", %{conn: conn} do
      conn = get(conn, query_path(conn, :new))
      assert html_response(conn, 200) =~ "New Query"
    end
  end

  describe "create query" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, query_path(conn, :create), query: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == query_path(conn, :show, id)

      conn = get(conn, query_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Query"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, query_path(conn, :create), query: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Query"
    end
  end

  describe "edit query" do
    setup [:create_query]

    test "renders form for editing chosen query", %{conn: conn, query: query} do
      conn = get(conn, query_path(conn, :edit, query))
      assert html_response(conn, 200) =~ "Edit Query"
    end
  end

  describe "update query" do
    setup [:create_query]

    test "redirects when data is valid", %{conn: conn, query: query} do
      conn = put(conn, query_path(conn, :update, query), query: @update_attrs)
      assert redirected_to(conn) == query_path(conn, :show, query)

      conn = get(conn, query_path(conn, :show, query))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, query: query} do
      conn = put(conn, query_path(conn, :update, query), query: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Query"
    end
  end

  describe "delete query" do
    setup [:create_query]

    test "deletes chosen query", %{conn: conn, query: query} do
      conn = delete(conn, query_path(conn, :delete, query))
      assert redirected_to(conn) == query_path(conn, :index)

      assert_error_sent(404, fn ->
        get(conn, query_path(conn, :show, query))
      end)
    end
  end

  defp create_query(_) do
    query = fixture(:query)
    {:ok, query: query}
  end
end
