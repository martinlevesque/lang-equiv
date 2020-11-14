defmodule LangEquivWeb.HomeLiveTest do
  use LangEquivWeb.ConnCase

  import Phoenix.LiveViewTest
  alias LangEquivWeb.HomeLive

  test "disconnected and connected render", %{conn: conn} do
    {:ok, home_live, disconnected_html} = live(conn, "/")

    txt_to_find = "Search for a snippet"

    assert disconnected_html =~ txt_to_find
    assert render(home_live) =~ txt_to_find
  end

  test "parse_search_query - basic search" do
    assert HomeLive.parse_search_query("asdf") == "asdf"
  end

  test "parse_search_query - should downcase" do
    assert HomeLive.parse_search_query("Asdf") == "asdf"
  end
end
