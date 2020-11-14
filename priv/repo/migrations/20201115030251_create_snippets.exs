defmodule LangEquiv.Repo.Migrations.CreateSnippets do
  use Ecto.Migration

  def change do
    create table(:snippets) do
      add :code, :string, size: 20000
      add :note, :string
      add :how_to_id, references(:how_tos, on_delete: :nothing)
      add :technology_id, references(:technologies, on_delete: :nothing)

      timestamps()
    end

    create index(:snippets, [:how_to_id])
    create index(:snippets, [:technology_id])
  end
end
