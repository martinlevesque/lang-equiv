defmodule LangEquivWeb.HowToLive.FormComponent do
  use LangEquivWeb, :live_component

  alias LangEquiv.Snippets

  @impl true
  def update(%{how_to: how_to} = assigns, socket) do
    changeset = Snippets.change_how_to(how_to)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"how_to" => how_to_params}, socket) do
    changeset =
      socket.assigns.how_to
      |> Snippets.change_how_to(how_to_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"how_to" => how_to_params}, socket) do
    save_how_to(socket, socket.assigns.action, how_to_params)
  end

  defp save_how_to(socket, :edit, how_to_params) do
    case Snippets.update_how_to(socket.assigns.how_to, how_to_params) do
      {:ok, _how_to} ->
        {:noreply,
         socket
         |> put_flash(:info, "How to updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_how_to(socket, :new, how_to_params) do
    case Snippets.create_how_to(how_to_params) do
      {:ok, _how_to} ->
        {:noreply,
         socket
         |> put_flash(:info, "How to created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
