defmodule RenameMeWeb.PageController do
  use RenameMeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
