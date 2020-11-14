defmodule LangEquivWeb.HowToLive.Show do
  use LangEquivWeb, :live_view

  alias LangEquiv.Snippets

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:how_to, Snippets.get_how_to!(id))}
  end

  defp page_title(:show), do: "Show How to"
  defp page_title(:edit), do: "Edit How to"
end
