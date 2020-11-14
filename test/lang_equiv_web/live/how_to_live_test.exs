defmodule LangEquivWeb.HowToLiveTest do
  use LangEquivWeb.ConnCase

  import Phoenix.LiveViewTest

  alias LangEquiv.Snippets

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  defp fixture(:how_to) do
    {:ok, how_to} = Snippets.create_how_to(@create_attrs)
    how_to
  end

  defp create_how_to(_) do
    how_to = fixture(:how_to)
    %{how_to: how_to}
  end

  describe "Index" do
    setup [:create_how_to]

    test "lists all how_tos", %{conn: conn, how_to: how_to} do
      {:ok, _index_live, html} = live(conn, Routes.how_to_index_path(conn, :index))

      assert html =~ "Listing How tos"
      assert html =~ how_to.description
    end

    test "saves new how_to", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.how_to_index_path(conn, :index))

      assert index_live |> element("a", "New How to") |> render_click() =~
               "New How to"

      assert_patch(index_live, Routes.how_to_index_path(conn, :new))

      assert index_live
             |> form("#how_to-form", how_to: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#how_to-form", how_to: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.how_to_index_path(conn, :index))

      assert html =~ "How to created successfully"
      assert html =~ "some description"
    end

    test "updates how_to in listing", %{conn: conn, how_to: how_to} do
      {:ok, index_live, _html} = live(conn, Routes.how_to_index_path(conn, :index))

      assert index_live |> element("#how_to-#{how_to.id} a", "Edit") |> render_click() =~
               "Edit How to"

      assert_patch(index_live, Routes.how_to_index_path(conn, :edit, how_to))

      assert index_live
             |> form("#how_to-form", how_to: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#how_to-form", how_to: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.how_to_index_path(conn, :index))

      assert html =~ "How to updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes how_to in listing", %{conn: conn, how_to: how_to} do
      {:ok, index_live, _html} = live(conn, Routes.how_to_index_path(conn, :index))

      assert index_live |> element("#how_to-#{how_to.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#how_to-#{how_to.id}")
    end
  end

  describe "Show" do
    setup [:create_how_to]

    test "displays how_to", %{conn: conn, how_to: how_to} do
      {:ok, _show_live, html} = live(conn, Routes.how_to_show_path(conn, :show, how_to))

      assert html =~ "Show How to"
      assert html =~ how_to.description
    end

    test "updates how_to within modal", %{conn: conn, how_to: how_to} do
      {:ok, show_live, _html} = live(conn, Routes.how_to_show_path(conn, :show, how_to))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit How to"

      assert_patch(show_live, Routes.how_to_show_path(conn, :edit, how_to))

      assert show_live
             |> form("#how_to-form", how_to: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#how_to-form", how_to: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.how_to_show_path(conn, :show, how_to))

      assert html =~ "How to updated successfully"
      assert html =~ "some updated description"
    end
  end
end
