defmodule LangEquivWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `LangEquivWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, LangEquivWeb.HowToLive.FormComponent,
        id: @how_to.id || :new,
        action: @live_action,
        how_to: @how_to,
        return_to: Routes.how_to_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, LangEquivWeb.ModalComponent, modal_opts)
  end

  def blank?(variable) do
    variable == "" || is_nil(variable)
  end
end
