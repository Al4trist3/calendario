defmodule CalendarioWeb.EventoLive.Show do
  use CalendarioWeb, :live_view

  alias Calendario.Agenda

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:evento, Agenda.get_evento!(id))}
  end

  defp page_title(:show), do: "Show Evento"
  defp page_title(:edit), do: "Edit Evento"
end
