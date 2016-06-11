defmodule Gaffer.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :email, :string
      add :crypted_password, :string

      timestamps
    end
    create unique_index(:accounts, [:email])

  end
end
