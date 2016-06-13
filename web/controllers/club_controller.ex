defmodule Gaffer.ClubController do
  use Gaffer.Web, :controller

  alias Gaffer.Club
  alias Gaffer.Repo

  def new(conn, _params) do
    changeset = Club.changeset(%Club{})
    render conn, changeset: changeset
  end

  def create(conn, %{"club" => club_params}) do
    changeset = Club.changeset(%Club{}, club_params)

    case Club.create(changeset, Repo) do
      {:ok, changeset} ->
        conn
        |> put_flash(:info, "Your club was created")
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Unable to create club")
        |> render("new.html", changeset: changeset)
    end
  end

  def index(conn, _params) do
    clubs = Repo.all(from c in Club)

    conn
    |> assign(:clubs, clubs)
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    club = Repo.get(Club, id)

    conn
    |> assign(:club, club)
    |> render("show.html")
  end

end
