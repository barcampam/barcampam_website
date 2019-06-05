defmodule Barcamp.Schedule do
  @moduledoc """
  The Schedule context.
  """

  import Ecto.Query, warn: false
  alias Barcamp.Repo
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Barcamp.Schedule.Talk

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of talks using filtrex
filters.

## Examples

    iex> list_talks(%{})
    %{talks: [%Talk{}], ...}
"""
@spec paginate_talks(map) :: {:ok, map} | {:error, any}
def paginate_talks(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:talks), params["talk"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_talks(filter, params) do
    {:ok,
      %{
        talks: page.entries,
        page_number: page.page_number,
        page_size: page.page_size,
        total_pages: page.total_pages,
        total_entries: page.total_entries,
        distance: @pagination_distance,
        sort_field: sort_field,
        sort_direction: sort_direction
      }
    }
  else
    {:error, error} -> {:error, error}
    error -> {:error, error}
  end
end

defp do_paginate_talks(filter, params) do
  Talk
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of talks.

## Examples

    iex> list_talks()
    [%Talk{}, ...]

"""
def list_talks do
  Repo.all(Talk)
end

@doc """
Gets a single talk.

Raises `Ecto.NoResultsError` if the Talk does not exist.

## Examples

    iex> get_talk!(123)
    %Talk{}

    iex> get_talk!(456)
    ** (Ecto.NoResultsError)

"""
def get_talk!(id), do: Repo.get!(Talk, id)

@doc """
Creates a talk.

## Examples

    iex> create_talk(%{field: value})
    {:ok, %Talk{}}

    iex> create_talk(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_talk(attrs \\ %{}) do
  %Talk{}
  |> Talk.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a talk.

## Examples

    iex> update_talk(talk, %{field: new_value})
    {:ok, %Talk{}}

    iex> update_talk(talk, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_talk(%Talk{} = talk, attrs) do
  talk
  |> Talk.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a Talk.

## Examples

    iex> delete_talk(talk)
    {:ok, %Talk{}}

    iex> delete_talk(talk)
    {:error, %Ecto.Changeset{}}

"""
def delete_talk(%Talk{} = talk) do
  Repo.delete(talk)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking talk changes.

## Examples

    iex> change_talk(talk)
    %Ecto.Changeset{source: %Talk{}}

"""
def change_talk(%Talk{} = talk) do
  Talk.changeset(talk, %{})
end

defp filter_config(:talks) do
  defconfig do
    text :title
      text :description
      text :room
      date :time_from
      date :time_to
      
  end
end
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Barcamp.Schedule.Stream

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of streams using filtrex
filters.

## Examples

    iex> list_streams(%{})
    %{streams: [%Stream{}], ...}
"""
@spec paginate_streams(map) :: {:ok, map} | {:error, any}
def paginate_streams(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:streams), params["stream"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_streams(filter, params) do
    {:ok,
      %{
        streams: page.entries,
        page_number: page.page_number,
        page_size: page.page_size,
        total_pages: page.total_pages,
        total_entries: page.total_entries,
        distance: @pagination_distance,
        sort_field: sort_field,
        sort_direction: sort_direction
      }
    }
  else
    {:error, error} -> {:error, error}
    error -> {:error, error}
  end
end

defp do_paginate_streams(filter, params) do
  Stream
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of streams.

## Examples

    iex> list_streams()
    [%Stream{}, ...]

"""
def list_streams do
  Repo.all(Stream)
end

@doc """
Gets a single stream.

Raises `Ecto.NoResultsError` if the Stream does not exist.

## Examples

    iex> get_stream!(123)
    %Stream{}

    iex> get_stream!(456)
    ** (Ecto.NoResultsError)

"""
def get_stream!(id), do: Repo.get!(Stream, id)

@doc """
Creates a stream.

## Examples

    iex> create_stream(%{field: value})
    {:ok, %Stream{}}

    iex> create_stream(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_stream(attrs \\ %{}) do
  %Stream{}
  |> Stream.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a stream.

## Examples

    iex> update_stream(stream, %{field: new_value})
    {:ok, %Stream{}}

    iex> update_stream(stream, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_stream(%Stream{} = stream, attrs) do
  stream
  |> Stream.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a Stream.

## Examples

    iex> delete_stream(stream)
    {:ok, %Stream{}}

    iex> delete_stream(stream)
    {:error, %Ecto.Changeset{}}

"""
def delete_stream(%Stream{} = stream) do
  Repo.delete(stream)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking stream changes.

## Examples

    iex> change_stream(stream)
    %Ecto.Changeset{source: %Stream{}}

"""
def change_stream(%Stream{} = stream) do
  Stream.changeset(stream, %{})
end

defp filter_config(:streams) do
  defconfig do
    text :link
      text :room
      
  end
end
end
