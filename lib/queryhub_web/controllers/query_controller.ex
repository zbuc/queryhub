defmodule QueryhubWeb.QueryController do
  use QueryhubWeb, :controller

  alias Queryhub.Osquery
  alias Queryhub.Osquery.Query

  def index(conn, _params) do
    queries = Osquery.list_queries()
    render(conn, "index.html", queries: queries)
  end

  def new(conn, _params) do
    changeset = Osquery.change_query(%Query{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"query" => query_params}) do
    case Osquery.create_query(query_params) do
      {:ok, query} ->
        conn
        |> put_flash(:info, "Query created successfully.")
        |> redirect(to: query_path(conn, :show, query))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    query = Osquery.get_query!(id)
    render(conn, "show.html", query: query)
  end

  def edit(conn, %{"id" => id}) do
    query = Osquery.get_query!(id)
    changeset = Osquery.change_query(query)
    render(conn, "edit.html", query: query, changeset: changeset)
  end

  def update(conn, %{"id" => id, "query" => query_params}) do
    query = Osquery.get_query!(id)

    case Osquery.update_query(query, query_params) do
      {:ok, query} ->
        conn
        |> put_flash(:info, "Query updated successfully.")
        |> redirect(to: query_path(conn, :show, query))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", query: query, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    query = Osquery.get_query!(id)
    {:ok, _query} = Osquery.delete_query(query)

    conn
    |> put_flash(:info, "Query deleted successfully.")
    |> redirect(to: query_path(conn, :index))
  end
end
