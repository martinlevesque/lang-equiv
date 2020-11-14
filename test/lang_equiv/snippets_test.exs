defmodule LangEquiv.SnippetsTest do
  use LangEquiv.DataCase

  alias LangEquiv.Snippets

  describe "how_tos" do
    alias LangEquiv.Snippets.HowTo

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def how_to_fixture(attrs \\ %{}) do
      {:ok, how_to} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Snippets.create_how_to()

      how_to
    end

    test "list_how_tos/0 returns all how_tos" do
      how_to = how_to_fixture()
      assert Snippets.list_how_tos() == [how_to]
    end

    test "get_how_to!/1 returns the how_to with given id" do
      how_to = how_to_fixture()
      assert Snippets.get_how_to!(how_to.id) == how_to
    end

    test "create_how_to/1 with valid data creates a how_to" do
      assert {:ok, %HowTo{} = how_to} = Snippets.create_how_to(@valid_attrs)
      assert how_to.description == "some description"
      assert how_to.name == "some name"
    end

    test "create_how_to/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Snippets.create_how_to(@invalid_attrs)
    end

    test "update_how_to/2 with valid data updates the how_to" do
      how_to = how_to_fixture()
      assert {:ok, %HowTo{} = how_to} = Snippets.update_how_to(how_to, @update_attrs)
      assert how_to.description == "some updated description"
      assert how_to.name == "some updated name"
    end

    test "update_how_to/2 with invalid data returns error changeset" do
      how_to = how_to_fixture()
      assert {:error, %Ecto.Changeset{}} = Snippets.update_how_to(how_to, @invalid_attrs)
      assert how_to == Snippets.get_how_to!(how_to.id)
    end

    test "delete_how_to/1 deletes the how_to" do
      how_to = how_to_fixture()
      assert {:ok, %HowTo{}} = Snippets.delete_how_to(how_to)
      assert_raise Ecto.NoResultsError, fn -> Snippets.get_how_to!(how_to.id) end
    end

    test "change_how_to/1 returns a how_to changeset" do
      how_to = how_to_fixture()
      assert %Ecto.Changeset{} = Snippets.change_how_to(how_to)
    end

    test "search_how_to with query only" do
      how_to = how_to_fixture()

      results = Snippets.search_how_to("name")

      assert length(results) == 1
      {:ok, first_element} = Enum.fetch(results, 0)
      assert first_element.name == "some name"
      assert first_element.id == how_to.id
    end

    test "search_how_to with empty query" do
      how_to = how_to_fixture()

      results = Snippets.search_how_to("")

      assert length(results) == 1
      {:ok, first_element} = Enum.fetch(results, 0)
      assert first_element.id == how_to.id
    end

    test "search_how_to with query only - no result" do
      Snippets.create_how_to(@valid_attrs)

      results = Snippets.search_how_to("invalidstuff")

      assert results = []
    end

    test "search_how_to with query and tech id" do
      {:ok, tech_cat} = Snippets.create_technology_category(%{name: "mytechcat"})
      {:ok, cplusplus} = Snippets.create_technology(%{name: "c++", technology_category_id: tech_cat.id})
      how_to = how_to_fixture()
      snippet = Snippets.create_snippet(
        %{
          name: "mysnip",
          code: "my code...",
          how_to_id: how_to.id,
          technology_id: cplusplus.id
        }
      )

      results = Snippets.search_how_to("name", cplusplus.id)

      assert results == [how_to]
    end

    test "search_how_to with query and not matching tech id" do
      {:ok, tech_cat} = Snippets.create_technology_category(%{name: "mytechcat"})
      {:ok, cplusplus} = Snippets.create_technology(%{name: "c++", technology_category_id: tech_cat.id})
      how_to = how_to_fixture()
      snippet = Snippets.create_snippet(
        %{
          name: "mysnip",
          code: "my code...",
          how_to_id: how_to.id
        }
      )

      results = Snippets.search_how_to("name", cplusplus.id)

      assert results == []
    end
  end

  describe "technology_categories" do
    alias LangEquiv.Snippets.TechnologyCategory

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def technology_category_fixture(attrs \\ %{}) do
      {:ok, technology_category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Snippets.create_technology_category()

      technology_category
    end

    test "list_technology_categories/0 returns all technology_categories" do
      technology_category = technology_category_fixture()
      assert Snippets.list_technology_categories() == [technology_category]
    end

    test "get_technology_category!/1 returns the technology_category with given id" do
      technology_category = technology_category_fixture()
      assert Snippets.get_technology_category!(technology_category.id) == technology_category
    end

    test "create_technology_category/1 with valid data creates a technology_category" do
      assert {:ok, %TechnologyCategory{} = technology_category} = Snippets.create_technology_category(@valid_attrs)
      assert technology_category.name == "some name"
    end

    test "create_technology_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Snippets.create_technology_category(@invalid_attrs)
    end

    test "update_technology_category/2 with valid data updates the technology_category" do
      technology_category = technology_category_fixture()
      assert {:ok, %TechnologyCategory{} = technology_category} = Snippets.update_technology_category(technology_category, @update_attrs)
      assert technology_category.name == "some updated name"
    end

    test "update_technology_category/2 with invalid data returns error changeset" do
      technology_category = technology_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Snippets.update_technology_category(technology_category, @invalid_attrs)
      assert technology_category == Snippets.get_technology_category!(technology_category.id)
    end

    test "delete_technology_category/1 deletes the technology_category" do
      technology_category = technology_category_fixture()
      assert {:ok, %TechnologyCategory{}} = Snippets.delete_technology_category(technology_category)
      assert_raise Ecto.NoResultsError, fn -> Snippets.get_technology_category!(technology_category.id) end
    end

    test "change_technology_category/1 returns a technology_category changeset" do
      technology_category = technology_category_fixture()
      assert %Ecto.Changeset{} = Snippets.change_technology_category(technology_category)
    end
  end

  describe "technologies" do
    alias LangEquiv.Snippets.Technology

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def technology_fixture(attrs \\ %{}) do
      {:ok, technology} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Snippets.create_technology()

      technology
    end

    test "list_technologies/0 returns all technologies" do
      technology = technology_fixture()
      assert Snippets.list_technologies() == [technology]
    end

    test "get_technology!/1 returns the technology with given id" do
      technology = technology_fixture()
      assert Snippets.get_technology!(technology.id) == technology
    end

    test "create_technology/1 with valid data creates a technology" do
      assert {:ok, %Technology{} = technology} = Snippets.create_technology(@valid_attrs)
      assert technology.name == "some name"
    end

    test "create_technology/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Snippets.create_technology(@invalid_attrs)
    end

    test "update_technology/2 with valid data updates the technology" do
      technology = technology_fixture()
      assert {:ok, %Technology{} = technology} = Snippets.update_technology(technology, @update_attrs)
      assert technology.name == "some updated name"
    end

    test "update_technology/2 with invalid data returns error changeset" do
      technology = technology_fixture()
      assert {:error, %Ecto.Changeset{}} = Snippets.update_technology(technology, @invalid_attrs)
      assert technology == Snippets.get_technology!(technology.id)
    end

    test "delete_technology/1 deletes the technology" do
      technology = technology_fixture()
      assert {:ok, %Technology{}} = Snippets.delete_technology(technology)
      assert_raise Ecto.NoResultsError, fn -> Snippets.get_technology!(technology.id) end
    end

    test "change_technology/1 returns a technology changeset" do
      technology = technology_fixture()
      assert %Ecto.Changeset{} = Snippets.change_technology(technology)
    end
  end

  describe "snippets" do
    alias LangEquiv.Snippets.Snippet

    @valid_attrs %{code: "some code", note: "some note"}
    @update_attrs %{code: "some updated code", note: "some updated note"}
    @invalid_attrs %{code: nil, note: nil}

    def snippet_fixture(attrs \\ %{}) do
      {:ok, snippet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Snippets.create_snippet()

      snippet
    end

    test "list_snippets/0 returns all snippets" do
      snippet = snippet_fixture()
      assert Snippets.list_snippets() == [snippet]
    end

    test "get_snippet!/1 returns the snippet with given id" do
      snippet = snippet_fixture()
      assert Snippets.get_snippet!(snippet.id) == snippet
    end

    test "create_snippet/1 with valid data creates a snippet" do
      assert {:ok, %Snippet{} = snippet} = Snippets.create_snippet(@valid_attrs)
      assert snippet.code == "some code"
      assert snippet.note == "some note"
    end

    test "create_snippet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Snippets.create_snippet(@invalid_attrs)
    end

    test "update_snippet/2 with valid data updates the snippet" do
      snippet = snippet_fixture()
      assert {:ok, %Snippet{} = snippet} = Snippets.update_snippet(snippet, @update_attrs)
      assert snippet.code == "some updated code"
      assert snippet.note == "some updated note"
    end

    test "update_snippet/2 with invalid data returns error changeset" do
      snippet = snippet_fixture()
      assert {:error, %Ecto.Changeset{}} = Snippets.update_snippet(snippet, @invalid_attrs)
      assert snippet == Snippets.get_snippet!(snippet.id)
    end

    test "delete_snippet/1 deletes the snippet" do
      snippet = snippet_fixture()
      assert {:ok, %Snippet{}} = Snippets.delete_snippet(snippet)
      assert_raise Ecto.NoResultsError, fn -> Snippets.get_snippet!(snippet.id) end
    end

    test "change_snippet/1 returns a snippet changeset" do
      snippet = snippet_fixture()
      assert %Ecto.Changeset{} = Snippets.change_snippet(snippet)
    end
  end
end
