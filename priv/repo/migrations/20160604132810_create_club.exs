defmodule Gaffer.Repo.Migrations.CreateClub do
  use Ecto.Migration

  def change do
    create table(:clubs) do
      add :name, :string
      add :color, :string
      add :logo, :string

      timestamps
    end

  end
end
