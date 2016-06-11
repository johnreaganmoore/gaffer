defmodule Gaffer.PageController do
  use Gaffer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
