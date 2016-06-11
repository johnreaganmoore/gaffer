defmodule Gaffer.SessionController do
  use Gaffer.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    case Gaffer.Session.login(session_params, Gaffer.Repo) do
      {:ok, account} ->
        conn
        |> put_session(:current_account, account.id)
        |> put_flash(:info, "Signed in :)")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_account)
    |> put_flash(:info, "Signed out")
    |> redirect(to: "/")
  end

end
