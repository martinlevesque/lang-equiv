defmodule LangEquivWeb.TechnologyCategoryLive.Show do
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
     |> assign(:technology_category, Snippets.get_technology_category!(id))}
  end

  defp page_title(:show), do: "Show Technology category"
  defp page_title(:edit), do: "Edit Technology category"
end
