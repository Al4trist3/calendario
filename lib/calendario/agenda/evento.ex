defmodule Calendario.Agenda.Evento do
  use Ecto.Schema
  import Ecto.Changeset

  schema "eventos" do
    field :titulo, :string
    field :descripcion, :string
    field :duracion, :integer
    field :fecha, :date
    field :inicio, :time

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(evento, attrs) do
    evento
    |> cast(attrs, [:titulo, :descripcion, :duracion, :fecha, :inicio])
    |> validate_required([:titulo, :descripcion, :duracion, :fecha, :inicio])
  end
end
