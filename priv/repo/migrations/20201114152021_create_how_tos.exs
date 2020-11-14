defmodule LangEquiv.Repo.Migrations.CreateHowTos do
  use Ecto.Migration

  def change do
    create table(:how_tos) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
