defmodule LangEquiv.Snippets do
  @moduledoc """
  The Snippets context.
  """

  import Ecto.Query, warn: false
  alias LangEquiv.Repo

  alias LangEquiv.Snippets.HowTo
  alias LangEquiv.Snippets.Snippet


  @doc """
  Returns the list of how_tos.


  ## Examples

      iex> list_how_tos()
      [%HowTo{}, ...]

  """
  def list_how_tos do
    Repo.all(HowTo)
  end

  @doc """
  Gets a single how_to.

  Raises `Ecto.NoResultsError` if the How to does not exist.

  ## Examples

      iex> get_how_to!(123)
      %HowTo{}

      iex> get_how_to!(456)
      ** (Ecto.NoResultsError)

  """
  def get_how_to!(id), do: Repo.get!(HowTo, id)

  def search_how_to(query, technology_id \\ nil, limit \\ 20) do
    howto_matching_query = if query != "" do
      from howto in HowTo,
        where: ilike(howto.name, ^"%#{query}%"),
        limit: ^limit
    else
      from howto in HowTo, limit: ^limit
    end

    query_to_resolve = if !is_nil(technology_id) && technology_id != "" do
      {tech_id_int, _} = Integer.parse("#{technology_id}")

      from h in howto_matching_query,
        join: s in Snippet,
        on: s.how_to_id == h.id,
        where: s.technology_id == ^tech_id_int
    else
      howto_matching_query
    end

    Repo.all(query_to_resolve)
  end

  @doc """
  Creates a how_to.

  ## Examples

      iex> create_how_to(%{field: value})
      {:ok, %HowTo{}}

      iex> create_how_to(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_how_to(attrs \\ %{}) do
    %HowTo{}
    |> HowTo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a how_to.

  ## Examples

      iex> update_how_to(how_to, %{field: new_value})
      {:ok, %HowTo{}}

      iex> update_how_to(how_to, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_how_to(%HowTo{} = how_to, attrs) do
    how_to
    |> HowTo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a how_to.

  ## Examples

      iex> delete_how_to(how_to)
      {:ok, %HowTo{}}

      iex> delete_how_to(how_to)
      {:error, %Ecto.Changeset{}}

  """
  def delete_how_to(%HowTo{} = how_to) do
    Repo.delete(how_to)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking how_to changes.

  ## Examples

      iex> change_how_to(how_to)
      %Ecto.Changeset{data: %HowTo{}}

  """
  def change_how_to(%HowTo{} = how_to, attrs \\ %{}) do
    HowTo.changeset(how_to, attrs)
  end

  def list_how_to_snippets(how_to_id) do
    # get snippets, preload technology
    # TODO
  end

  alias LangEquiv.Snippets.TechnologyCategory

  @doc """
  Returns the list of technology_categories.

  ## Examples

      iex> list_technology_categories()
      [%TechnologyCategory{}, ...]

  """
  def list_technology_categories do
    Repo.all(TechnologyCategory)
  end

  @doc """
  Gets a single technology_category.

  Raises `Ecto.NoResultsError` if the Technology category does not exist.

  ## Examples

      iex> get_technology_category!(123)
      %TechnologyCategory{}

      iex> get_technology_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_technology_category!(id), do: Repo.get!(TechnologyCategory, id)

  @doc """
  Creates a technology_category.

  ## Examples

      iex> create_technology_category(%{field: value})
      {:ok, %TechnologyCategory{}}

      iex> create_technology_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_technology_category(attrs \\ %{}) do
    %TechnologyCategory{}
    |> TechnologyCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a technology_category.

  ## Examples

      iex> update_technology_category(technology_category, %{field: new_value})
      {:ok, %TechnologyCategory{}}

      iex> update_technology_category(technology_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_technology_category(%TechnologyCategory{} = technology_category, attrs) do
    technology_category
    |> TechnologyCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a technology_category.

  ## Examples

      iex> delete_technology_category(technology_category)
      {:ok, %TechnologyCategory{}}

      iex> delete_technology_category(technology_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_technology_category(%TechnologyCategory{} = technology_category) do
    Repo.delete(technology_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking technology_category changes.

  ## Examples

      iex> change_technology_category(technology_category)
      %Ecto.Changeset{data: %TechnologyCategory{}}

  """
  def change_technology_category(%TechnologyCategory{} = technology_category, attrs \\ %{}) do
    TechnologyCategory.changeset(technology_category, attrs)
  end

  alias LangEquiv.Snippets.Technology

  @doc """
  Returns the list of technologies.

  ## Examples

      iex> list_technologies()
      [%Technology{}, ...]

  """
  def list_technologies do
    Repo.all(Technology)
  end

  @doc """
  Gets a single technology.

  Raises `Ecto.NoResultsError` if the Technology does not exist.

  ## Examples

      iex> get_technology!(123)
      %Technology{}

      iex> get_technology!(456)
      ** (Ecto.NoResultsError)

  """
  def get_technology!(id), do: Repo.get!(Technology, id)

  @doc """
  Creates a technology.

  ## Examples

      iex> create_technology(%{field: value})
      {:ok, %Technology{}}

      iex> create_technology(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_technology(attrs \\ %{}) do
    %Technology{}
    |> Technology.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a technology.

  ## Examples

      iex> update_technology(technology, %{field: new_value})
      {:ok, %Technology{}}

      iex> update_technology(technology, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_technology(%Technology{} = technology, attrs) do
    technology
    |> Technology.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a technology.

  ## Examples

      iex> delete_technology(technology)
      {:ok, %Technology{}}

      iex> delete_technology(technology)
      {:error, %Ecto.Changeset{}}

  """
  def delete_technology(%Technology{} = technology) do
    Repo.delete(technology)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking technology changes.

  ## Examples

      iex> change_technology(technology)
      %Ecto.Changeset{data: %Technology{}}

  """
  def change_technology(%Technology{} = technology, attrs \\ %{}) do
    Technology.changeset(technology, attrs)
  end

  alias LangEquiv.Snippets.Snippet

  @doc """
  Returns the list of snippets.

  ## Examples

      iex> list_snippets()
      [%Snippet{}, ...]

  """
  def list_snippets do
    Repo.all(Snippet)
  end

  @doc """
  Gets a single snippet.

  Raises `Ecto.NoResultsError` if the Snippet does not exist.

  ## Examples

      iex> get_snippet!(123)
      %Snippet{}

      iex> get_snippet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_snippet!(id), do: Repo.get!(Snippet, id)

  @doc """
  Creates a snippet.

  ## Examples

      iex> create_snippet(%{field: value})
      {:ok, %Snippet{}}

      iex> create_snippet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_snippet(attrs \\ %{}) do
    %Snippet{}
    |> Snippet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a snippet.

  ## Examples

      iex> update_snippet(snippet, %{field: new_value})
      {:ok, %Snippet{}}

      iex> update_snippet(snippet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_snippet(%Snippet{} = snippet, attrs) do
    snippet
    |> Snippet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a snippet.

  ## Examples

      iex> delete_snippet(snippet)
      {:ok, %Snippet{}}

      iex> delete_snippet(snippet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_snippet(%Snippet{} = snippet) do
    Repo.delete(snippet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking snippet changes.

  ## Examples

      iex> change_snippet(snippet)
      %Ecto.Changeset{data: %Snippet{}}

  """
  def change_snippet(%Snippet{} = snippet, attrs \\ %{}) do
    Snippet.changeset(snippet, attrs)
  end
end
