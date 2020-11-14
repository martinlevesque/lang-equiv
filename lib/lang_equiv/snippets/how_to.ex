defmodule LangEquiv.Snippets.HowTo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "how_tos" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(how_to, attrs) do
    how_to
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
