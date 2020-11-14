defmodule LangEquiv.Snippets.Technology do
  use Ecto.Schema
  import Ecto.Changeset

  schema "technologies" do
    field :name, :string
    field :technology_category_id, :id

    timestamps()
  end

  @doc false
  def changeset(technology, attrs) do
    technology
    |> cast(attrs, [:name, :technology_category_id])
    |> validate_required([:name])
  end
end
