defmodule Calendario.AgendaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Calendario.Agenda` context.
  """

  @doc """
  Generate a evento.
  """
  def evento_fixture(attrs \\ %{}) do
    {:ok, evento} =
      attrs
      |> Enum.into(%{
        descripcion: "some descripcion",
        duracion: 42,
        fecha: ~D[2024-06-29],
        inicio: ~T[14:00:00],
        titulo: "some titulo"
      })
      |> Calendario.Agenda.create_evento()

    evento
  end
end
