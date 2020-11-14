defmodule LangEquivWeb.TechnologyLive.FormComponent do
  use LangEquivWeb, :live_component
  require Logger

  alias LangEquiv.Snippets

  @impl true
  def update(%{technology: technology} = assigns, socket) do
    changeset = Snippets.change_technology(technology)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:technology_categories, Snippets.list_technology_categories)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"technology" => technology_params}, socket) do
    changeset =
      socket.assigns.technology
      |> Snippets.change_technology(technology_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"technology" => technology_params}, socket) do
    save_technology(socket, socket.assigns.action, technology_params)
  end

  defp save_technology(socket, :edit, technology_params) do
    case Snippets.update_technology(socket.assigns.technology, technology_params) do
      {:ok, _technology} ->
        {:noreply,
         socket
         |> put_flash(:info, "Technology updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_technology(socket, :new, technology_params) do
    case Snippets.create_technology(technology_params) do
      {:ok, _technology} ->
        {:noreply,
         socket
         |> put_flash(:info, "Technology created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
