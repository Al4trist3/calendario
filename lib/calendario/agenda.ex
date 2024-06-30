defmodule Calendario.Agenda do
  @moduledoc """
  The Agenda context.
  """

  import Ecto.Query, warn: false
  alias Calendario.Repo

  alias Calendario.Agenda.Evento

  @doc """
  Returns the list of eventos.

  ## Examples

      iex> list_eventos()
      [%Evento{}, ...]

  """
  def list_eventos do
    Repo.all(Evento)
  end

  def list_eventos(fecha) do
    query = from(e in Evento, where: e.fecha == ^fecha)
    Repo.all(query)
  end

  @doc """
  Gets a single evento.

  Raises `Ecto.NoResultsError` if the Evento does not exist.

  ## Examples

      iex> get_evento!(123)
      %Evento{}

      iex> get_evento!(456)
      ** (Ecto.NoResultsError)

  """
  def get_evento!(id), do: Repo.get!(Evento, id)

  @doc """
  Creates a evento.

  ## Examples

      iex> create_evento(%{field: value})
      {:ok, %Evento{}}

      iex> create_evento(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_evento(attrs \\ %{}) do
    %Evento{}
    |> Evento.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a evento.

  ## Examples

      iex> update_evento(evento, %{field: new_value})
      {:ok, %Evento{}}

      iex> update_evento(evento, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_evento(%Evento{} = evento, attrs) do
    evento
    |> Evento.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a evento.

  ## Examples

      iex> delete_evento(evento)
      {:ok, %Evento{}}

      iex> delete_evento(evento)
      {:error, %Ecto.Changeset{}}

  """
  def delete_evento(%Evento{} = evento) do
    Repo.delete(evento)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking evento changes.

  ## Examples

      iex> change_evento(evento)
      %Ecto.Changeset{data: %Evento{}}

  """
  def change_evento(%Evento{} = evento, attrs \\ %{}) do
    Evento.changeset(evento, attrs)
  end
end
