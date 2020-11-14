defmodule LangEquivWeb.TechnologyLiveTest do
  use LangEquivWeb.ConnCase

  import Phoenix.LiveViewTest

  alias LangEquiv.Snippets

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:technology) do
    {:ok, technology} = Snippets.create_technology(@create_attrs)
    technology
  end

  defp create_technology(_) do
    technology = fixture(:technology)
    %{technology: technology}
  end

  describe "Index" do
    setup [:create_technology]

    test "lists all technologies", %{conn: conn, technology: technology} do
      {:ok, _index_live, html} = live(conn, Routes.technology_index_path(conn, :index))

      assert html =~ "Listing Technologies"
      assert html =~ technology.name
    end

    test "saves new technology", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.technology_index_path(conn, :index))

      assert index_live |> element("a", "New Technology") |> render_click() =~
               "New Technology"

      assert_patch(index_live, Routes.technology_index_path(conn, :new))

      assert index_live
             |> form("#technology-form", technology: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#technology-form", technology: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.technology_index_path(conn, :index))

      assert html =~ "Technology created successfully"
      assert html =~ "some name"
    end

    test "updates technology in listing", %{conn: conn, technology: technology} do
      {:ok, index_live, _html} = live(conn, Routes.technology_index_path(conn, :index))

      assert index_live |> element("#technology-#{technology.id} a", "Edit") |> render_click() =~
               "Edit Technology"

      assert_patch(index_live, Routes.technology_index_path(conn, :edit, technology))

      assert index_live
             |> form("#technology-form", technology: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#technology-form", technology: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.technology_index_path(conn, :index))

      assert html =~ "Technology updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes technology in listing", %{conn: conn, technology: technology} do
      {:ok, index_live, _html} = live(conn, Routes.technology_index_path(conn, :index))

      assert index_live |> element("#technology-#{technology.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#technology-#{technology.id}")
    end
  end

  describe "Show" do
    setup [:create_technology]

    test "displays technology", %{conn: conn, technology: technology} do
      {:ok, _show_live, html} = live(conn, Routes.technology_show_path(conn, :show, technology))

      assert html =~ "Show Technology"
      assert html =~ technology.name
    end

    test "updates technology within modal", %{conn: conn, technology: technology} do
      {:ok, show_live, _html} = live(conn, Routes.technology_show_path(conn, :show, technology))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Technology"

      assert_patch(show_live, Routes.technology_show_path(conn, :edit, technology))

      assert show_live
             |> form("#technology-form", technology: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#technology-form", technology: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.technology_show_path(conn, :show, technology))

      assert html =~ "Technology updated successfully"
      assert html =~ "some updated name"
    end
  end
end
