defmodule LangEquivWeb.TechnologyCategoryLiveTest do
  use LangEquivWeb.ConnCase

  import Phoenix.LiveViewTest

  alias LangEquiv.Snippets

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:technology_category) do
    {:ok, technology_category} = Snippets.create_technology_category(@create_attrs)
    technology_category
  end

  defp create_technology_category(_) do
    technology_category = fixture(:technology_category)
    %{technology_category: technology_category}
  end

  describe "Index" do
    setup [:create_technology_category]

    test "lists all technology_categories", %{conn: conn, technology_category: technology_category} do
      {:ok, _index_live, html} = live(conn, Routes.technology_category_index_path(conn, :index))

      assert html =~ "Listing Technology categories"
      assert html =~ technology_category.name
    end

    test "saves new technology_category", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.technology_category_index_path(conn, :index))

      assert index_live |> element("a", "New Technology category") |> render_click() =~
               "New Technology category"

      assert_patch(index_live, Routes.technology_category_index_path(conn, :new))

      assert index_live
             |> form("#technology_category-form", technology_category: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#technology_category-form", technology_category: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.technology_category_index_path(conn, :index))

      assert html =~ "Technology category created successfully"
      assert html =~ "some name"
    end

    test "updates technology_category in listing", %{conn: conn, technology_category: technology_category} do
      {:ok, index_live, _html} = live(conn, Routes.technology_category_index_path(conn, :index))

      assert index_live |> element("#technology_category-#{technology_category.id} a", "Edit") |> render_click() =~
               "Edit Technology category"

      assert_patch(index_live, Routes.technology_category_index_path(conn, :edit, technology_category))

      assert index_live
             |> form("#technology_category-form", technology_category: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#technology_category-form", technology_category: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.technology_category_index_path(conn, :index))

      assert html =~ "Technology category updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes technology_category in listing", %{conn: conn, technology_category: technology_category} do
      {:ok, index_live, _html} = live(conn, Routes.technology_category_index_path(conn, :index))

      assert index_live |> element("#technology_category-#{technology_category.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#technology_category-#{technology_category.id}")
    end
  end

  describe "Show" do
    setup [:create_technology_category]

    test "displays technology_category", %{conn: conn, technology_category: technology_category} do
      {:ok, _show_live, html} = live(conn, Routes.technology_category_show_path(conn, :show, technology_category))

      assert html =~ "Show Technology category"
      assert html =~ technology_category.name
    end

    test "updates technology_category within modal", %{conn: conn, technology_category: technology_category} do
      {:ok, show_live, _html} = live(conn, Routes.technology_category_show_path(conn, :show, technology_category))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Technology category"

      assert_patch(show_live, Routes.technology_category_show_path(conn, :edit, technology_category))

      assert show_live
             |> form("#technology_category-form", technology_category: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#technology_category-form", technology_category: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.technology_category_show_path(conn, :show, technology_category))

      assert html =~ "Technology category updated successfully"
      assert html =~ "some updated name"
    end
  end
end
