defmodule LangEquivWeb.SnippetLive.Index do
  use LangEquivWeb, :live_view

  alias LangEquiv.Snippets
  alias LangEquiv.Snippets.Snippet

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :snippets, list_snippets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Snippet")
    |> assign(:snippet, Snippets.get_snippet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Snippet")
    |> assign(:snippet, %Snippet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Snippets")
    |> assign(:snippet, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    snippet = Snippets.get_snippet!(id)
    {:ok, _} = Snippets.delete_snippet(snippet)

    {:noreply, assign(socket, :snippets, list_snippets())}
  end

  defp list_snippets do
    Snippets.list_snippets()
  end
end
