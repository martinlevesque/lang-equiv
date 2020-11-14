defmodule LangEquivWeb.TechnologyCategoryLive.FormComponent do
  use LangEquivWeb, :live_component

  alias LangEquiv.Snippets

  @impl true
  def update(%{technology_category: technology_category} = assigns, socket) do
    changeset = Snippets.change_technology_category(technology_category)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"technology_category" => technology_category_params}, socket) do
    changeset =
      socket.assigns.technology_category
      |> Snippets.change_technology_category(technology_category_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"technology_category" => technology_category_params}, socket) do
    save_technology_category(socket, socket.assigns.action, technology_category_params)
  end

  defp save_technology_category(socket, :edit, technology_category_params) do
    case Snippets.update_technology_category(socket.assigns.technology_category, technology_category_params) do
      {:ok, _technology_category} ->
        {:noreply,
         socket
         |> put_flash(:info, "Technology category updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_technology_category(socket, :new, technology_category_params) do
    case Snippets.create_technology_category(technology_category_params) do
      {:ok, _technology_category} ->
        {:noreply,
         socket
         |> put_flash(:info, "Technology category created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
