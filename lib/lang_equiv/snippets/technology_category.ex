defmodule LangEquiv.Snippets.TechnologyCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "technology_categories" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(technology_category, attrs) do
    technology_category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
