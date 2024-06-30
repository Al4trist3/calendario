defmodule CalendarioWeb.EventoLive.FormComponent do
  use CalendarioWeb, :live_component

  alias Calendario.Agenda

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Ingrese los datos del evento.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="evento-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:titulo]} type="text" label="Titulo" />
        <.input field={@form[:descripcion]} type="text" label="Descripcion" />
        <.input field={@form[:duracion]} type="number" label="Duracion" min="0" />
        <.input field={@form[:fecha]} type="date" label="Fecha" value={@date} />
        <.input field={@form[:inicio]} type="time" label="Inicio" />
        <:actions>
          <.button phx-disable-with="Saving...">Guardar evento</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{evento: evento} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Agenda.change_evento(evento))
     end)}
  end

  @impl true
  def handle_event("validate", %{"evento" => evento_params}, socket) do
    changeset = Agenda.change_evento(socket.assigns.evento, evento_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"evento" => evento_params}, socket) do
    save_evento(socket, socket.assigns.action, evento_params)
  end

  defp save_evento(socket, :edit, evento_params) do
    case Agenda.update_evento(socket.assigns.evento, evento_params) do
      {:ok, evento} ->
        notify_parent({:saved, evento})

        {:noreply,
         socket
         |> put_flash(:info, "Evento editado satisfactoriamente")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_evento(socket, :new, evento_params) do
    case Agenda.create_evento(evento_params) do
      {:ok, evento} ->
        notify_parent({:saved, evento})

        {:noreply,
         socket
         |> put_flash(:info, "Evento creado satisfactoriamente")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
