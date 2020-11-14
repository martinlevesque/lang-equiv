defmodule LangEquivWeb.HomeLive do
  require Logger
  use LangEquivWeb, :live_view

  alias LangEquiv.Snippets

  defp form_attributes(socket, %{query: query, technology_id: technology_id}) do
    assign(
      socket,
      results: search(query, technology_id),
      technologies: Snippets.list_technologies,
      query: query,
      technology_id: technology_id)
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, form_attributes(socket, %{query: "", technology_id: ""})}
  end

  @impl true
  def handle_event("suggest", %{"q" => query, "technology_id" => technology_id}, socket) do
    {:noreply, form_attributes(socket, %{query: query, technology_id: technology_id})}
  end

  @impl true
  def handle_event("goto", %{"q" => query, "technology-id" => technology_id, "id" => id}, socket) do
    if blank?(technology_id) do
      mylist = ["titi"]
      {
        :noreply,
        form_attributes(socket, %{query: query, technology_id: technology_id})
          |> assign(:mylist, mylist)
      }
    else
      {:noreply}
    end
  end

  def search(query, technology_id \\ nil) do
    query
      |> parse_search_query
      |> Snippets.search_how_to(technology_id)
  end

  def parse_search_query(query) do
    query
      |> String.downcase
      |> String.trim
  end
end
