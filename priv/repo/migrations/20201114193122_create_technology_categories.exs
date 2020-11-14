defmodule LangEquiv.Repo.Migrations.CreateTechnologyCategories do
  use Ecto.Migration

  def change do
    create table(:technology_categories) do
      add :name, :string

      timestamps()
    end

  end
end
