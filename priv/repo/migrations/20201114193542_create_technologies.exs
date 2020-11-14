defmodule LangEquiv.Repo.Migrations.CreateTechnologies do
  use Ecto.Migration

  def change do
    create table(:technologies) do
      add :name, :string
      add :technology_category_id, references(:technology_categories, on_delete: :nothing)

      timestamps()
    end

    create index(:technologies, [:technology_category_id])
  end
end
