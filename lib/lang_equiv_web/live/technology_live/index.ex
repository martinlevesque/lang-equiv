defmodule LangEquivWeb.TechnologyLive.Index do
  use LangEquivWeb, :live_view

  alias LangEquiv.Snippets
  alias LangEquiv.Snippets.Technology

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :technologies, list_technologies())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Technology")
    |> assign(:technology, Snippets.get_technology!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Technology")
    |> assign(:technology, %Technology{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Technologies")
    |> assign(:technology, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    technology = Snippets.get_technology!(id)
    {:ok, _} = Snippets.delete_technology(technology)

    {:noreply, assign(socket, :technologies, list_technologies())}
  end

  defp list_technologies do
    Snippets.list_technologies()
  end
end
