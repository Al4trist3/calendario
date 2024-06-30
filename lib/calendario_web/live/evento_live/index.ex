defmodule CalendarioWeb.EventoLive.Index do
  use CalendarioWeb, :live_view

  alias Calendario.Agenda
  alias Calendario.Agenda.Evento

  @impl true
  def mount(_params, _session, socket) do

    IO.inspect(socket.assigns)
    date = Date.to_string(Date.utc_today())
    socket = assign(socket, :date, date)
    {:ok, stream(socket, :eventos, Agenda.list_eventos(date))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Evento")
    |> assign(:evento, Agenda.get_evento!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Evento")
    |> assign(:evento, %Evento{})
  end

  defp apply_action(socket, :index, _params) do

    socket
    |> assign(:page_title, "Listing Eventos")
    |> assign(:evento, nil)
  end

  @impl true
  def handle_info({CalendarioWeb.EventoLive.FormComponent, {:saved, evento}}, socket) do
    {:noreply, stream_insert(socket, :eventos, evento)}
  end

  def handle_info({CalendarioWeb.EventoLive.CalendarioComponent, {:updated_date, date}}, socket) do
    socket =
      socket
      |> assign(:date, date)
    {:noreply, stream(socket, :eventos, Agenda.list_eventos(date), reset: true)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    evento = Agenda.get_evento!(id)
    {:ok, _} = Agenda.delete_evento(evento)

    {:noreply, stream_delete(socket, :eventos, evento)}
  end
end
