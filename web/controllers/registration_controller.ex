defmodule Gaffer.RegistrationController do
  use Gaffer.Web, :controller
  alias Gaffer.Account

  def new(conn, _params) do
    changeset = Account.changeset(%Account{})
    render conn, changeset: changeset
  end

  def create(conn, %{"account" => account_params}) do
    changeset = Account.changeset(%Account{}, account_params)

    case Gaffer.Registration.create(changeset, Gaffer.Repo) do
      {:ok, changeset} ->
        conn
        |> put_session(:current_account, changeset.id)
        |> put_flash(:info, "Your account was created")
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Unable to create account")
        |> render("new.html", changeset: changeset)
    end
  end



end
