defmodule Calendario.Repo.Migrations.CreateEventos do
  use Ecto.Migration

  def change do
    create table(:eventos) do
      add :titulo, :string
      add :descripcion, :string
      add :duracion, :integer
      add :fecha, :date
      add :inicio, :time

      timestamps(type: :utc_datetime)
    end
  end
end
