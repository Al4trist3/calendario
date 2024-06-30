defmodule Calendario.AgendaTest do
  use Calendario.DataCase

  alias Calendario.Agenda

  describe "eventos" do
    alias Calendario.Agenda.Evento

    import Calendario.AgendaFixtures

    @invalid_attrs %{titulo: nil, descripcion: nil, duracion: nil, fecha: nil, inicio: nil}

    test "list_eventos/0 returns all eventos" do
      evento = evento_fixture()
      assert Agenda.list_eventos() == [evento]
    end

    test "get_evento!/1 returns the evento with given id" do
      evento = evento_fixture()
      assert Agenda.get_evento!(evento.id) == evento
    end

    test "create_evento/1 with valid data creates a evento" do
      valid_attrs = %{titulo: "some titulo", descripcion: "some descripcion", duracion: 42, fecha: ~D[2024-06-29], inicio: ~T[14:00:00]}

      assert {:ok, %Evento{} = evento} = Agenda.create_evento(valid_attrs)
      assert evento.titulo == "some titulo"
      assert evento.descripcion == "some descripcion"
      assert evento.duracion == 42
      assert evento.fecha == ~D[2024-06-29]
      assert evento.inicio == ~T[14:00:00]
    end

    test "create_evento/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Agenda.create_evento(@invalid_attrs)
    end

    test "update_evento/2 with valid data updates the evento" do
      evento = evento_fixture()
      update_attrs = %{titulo: "some updated titulo", descripcion: "some updated descripcion", duracion: 43, fecha: ~D[2024-06-30], inicio: ~T[15:01:01]}

      assert {:ok, %Evento{} = evento} = Agenda.update_evento(evento, update_attrs)
      assert evento.titulo == "some updated titulo"
      assert evento.descripcion == "some updated descripcion"
      assert evento.duracion == 43
      assert evento.fecha == ~D[2024-06-30]
      assert evento.inicio == ~T[15:01:01]
    end

    test "update_evento/2 with invalid data returns error changeset" do
      evento = evento_fixture()
      assert {:error, %Ecto.Changeset{}} = Agenda.update_evento(evento, @invalid_attrs)
      assert evento == Agenda.get_evento!(evento.id)
    end

    test "delete_evento/1 deletes the evento" do
      evento = evento_fixture()
      assert {:ok, %Evento{}} = Agenda.delete_evento(evento)
      assert_raise Ecto.NoResultsError, fn -> Agenda.get_evento!(evento.id) end
    end

    test "change_evento/1 returns a evento changeset" do
      evento = evento_fixture()
      assert %Ecto.Changeset{} = Agenda.change_evento(evento)
    end
  end
end
