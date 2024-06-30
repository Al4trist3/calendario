defmodule CalendarioWeb.EventoLiveTest do
  use CalendarioWeb.ConnCase

  import Phoenix.LiveViewTest
  import Calendario.AgendaFixtures

  @create_attrs %{titulo: "some titulo", descripcion: "some descripcion", duracion: 42, fecha: "2024-06-29", inicio: "14:00"}
  @update_attrs %{titulo: "some updated titulo", descripcion: "some updated descripcion", duracion: 43, fecha: "2024-06-30", inicio: "15:01"}
  @invalid_attrs %{titulo: nil, descripcion: nil, duracion: nil, fecha: nil, inicio: nil}

  defp create_evento(_) do
    evento = evento_fixture()
    %{evento: evento}
  end

  describe "Index" do
    setup [:create_evento]

    test "lists all eventos", %{conn: conn, evento: evento} do
      {:ok, _index_live, html} = live(conn, ~p"/eventos")

      assert html =~ "Listing Eventos"
      assert html =~ evento.titulo
    end

    test "saves new evento", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/eventos")

      assert index_live |> element("a", "New Evento") |> render_click() =~
               "New Evento"

      assert_patch(index_live, ~p"/eventos/new")

      assert index_live
             |> form("#evento-form", evento: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#evento-form", evento: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/eventos")

      html = render(index_live)
      assert html =~ "Evento created successfully"
      assert html =~ "some titulo"
    end

    test "updates evento in listing", %{conn: conn, evento: evento} do
      {:ok, index_live, _html} = live(conn, ~p"/eventos")

      assert index_live |> element("#eventos-#{evento.id} a", "Edit") |> render_click() =~
               "Edit Evento"

      assert_patch(index_live, ~p"/eventos/#{evento}/edit")

      assert index_live
             |> form("#evento-form", evento: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#evento-form", evento: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/eventos")

      html = render(index_live)
      assert html =~ "Evento updated successfully"
      assert html =~ "some updated titulo"
    end

    test "deletes evento in listing", %{conn: conn, evento: evento} do
      {:ok, index_live, _html} = live(conn, ~p"/eventos")

      assert index_live |> element("#eventos-#{evento.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#eventos-#{evento.id}")
    end
  end

  describe "Show" do
    setup [:create_evento]

    test "displays evento", %{conn: conn, evento: evento} do
      {:ok, _show_live, html} = live(conn, ~p"/eventos/#{evento}")

      assert html =~ "Show Evento"
      assert html =~ evento.titulo
    end

    test "updates evento within modal", %{conn: conn, evento: evento} do
      {:ok, show_live, _html} = live(conn, ~p"/eventos/#{evento}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Evento"

      assert_patch(show_live, ~p"/eventos/#{evento}/show/edit")

      assert show_live
             |> form("#evento-form", evento: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#evento-form", evento: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/eventos/#{evento}")

      html = render(show_live)
      assert html =~ "Evento updated successfully"
      assert html =~ "some updated titulo"
    end
  end
end
