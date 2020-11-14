defmodule LangEquiv.Snippets.Snippet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "snippets" do
    field :code, :string
    field :note, :string
    field :how_to_id, :id
    field :technology_id, :id

    timestamps()
  end

  @doc false
  def changeset(snippet, attrs) do
    snippet
    |> cast(attrs, [:how_to_id, :technology_id, :code, :note])
    |> validate_required([:code])
  end
end
