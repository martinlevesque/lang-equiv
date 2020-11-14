defmodule LangEquivWeb.HowToLive.Index do
  use LangEquivWeb, :live_view

  alias LangEquiv.Snippets
  alias LangEquiv.Snippets.HowTo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :how_tos, list_how_tos())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit How to")
    |> assign(:how_to, Snippets.get_how_to!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New How to")
    |> assign(:how_to, %HowTo{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing How tos")
    |> assign(:how_to, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    how_to = Snippets.get_how_to!(id)
    {:ok, _} = Snippets.delete_how_to(how_to)

    {:noreply, assign(socket, :how_tos, list_how_tos())}
  end

  defp list_how_tos do
    Snippets.list_how_tos()
  end
end
