defmodule Gaffer.Session do
  alias Gaffer.Account

  def login(params, repo) do
    account = repo.get_by(Account, email: String.downcase(params["email"]))
    case authenticate(account, params["password"]) do
      true -> {:ok, account}
      _    -> :error
    end
  end

  def current_account(conn) do
    id = Plug.Conn.get_session(conn, :current_account)
    if id, do: Gaffer.Repo.get(Account, id)
  end

  def logged_in?(conn), do: !!current_account(conn)

  # Private

  defp authenticate(account, password) do
    case account do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, account.crypted_password)
    end
  end

end
