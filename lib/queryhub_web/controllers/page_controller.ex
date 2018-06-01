defmodule QueryhubWeb.PageController do
  use QueryhubWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
