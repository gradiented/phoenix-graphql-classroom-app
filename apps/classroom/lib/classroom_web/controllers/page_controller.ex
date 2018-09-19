defmodule ClassroomWeb.PageController do
  use ClassroomWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
