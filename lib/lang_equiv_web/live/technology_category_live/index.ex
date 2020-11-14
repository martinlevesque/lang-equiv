defmodule LangEquivWeb.TechnologyCategoryLive.Index do
  use LangEquivWeb, :live_view

  alias LangEquiv.Snippets
  alias LangEquiv.Snippets.TechnologyCategory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :technology_categories, list_technology_categories())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Technology category")
    |> assign(:technology_category, Snippets.get_technology_category!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Technology category")
    |> assign(:technology_category, %TechnologyCategory{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Technology categories")
    |> assign(:technology_category, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    technology_category = Snippets.get_technology_category!(id)
    {:ok, _} = Snippets.delete_technology_category(technology_category)

    {:noreply, assign(socket, :technology_categories, list_technology_categories())}
  end

  defp list_technology_categories do
    Snippets.list_technology_categories()
  end
end
