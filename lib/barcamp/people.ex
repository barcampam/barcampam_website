defmodule Barcamp.People do
  @moduledoc """
  The People context.
  """

  import Ecto.Query, warn: false
  alias Barcamp.Repo
  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config

  alias Barcamp.People.Speaker

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of speakers using filtrex
  filters.

  ## Examples

      iex> list_speakers(%{})
      %{speakers: [%Speaker{}], ...}
  """
  @spec paginate_speakers(map) :: {:ok, map} | {:error, any}
  def paginate_speakers(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <-
           Filtrex.parse_params(filter_config(:speakers), params["speaker"] || %{}),
         %Scrivener.Page{} = page <- do_paginate_speakers(filter, params) do
      {:ok,
       %{
         speakers: page.entries,
         page_number: page.page_number,
         page_size: page.page_size,
         total_pages: page.total_pages,
         total_entries: page.total_entries,
         distance: @pagination_distance,
         sort_field: sort_field,
         sort_direction: sort_direction
       }}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_speakers(filter, params) do
    Speaker
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of speakers.

  ## Examples

      iex> list_speakers()
      [%Speaker{}, ...]

  """
  def list_speakers do
    Repo.all(Speaker)
  end

  @doc """
  Gets a single speaker.

  Raises `Ecto.NoResultsError` if the Speaker does not exist.

  ## Examples

      iex> get_speaker!(123)
      %Speaker{}

      iex> get_speaker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_speaker!(id), do: Repo.get!(Speaker, id)

  @doc """
  Creates a speaker.

  ## Examples

      iex> create_speaker(%{field: value})
      {:ok, %Speaker{}}

      iex> create_speaker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_speaker(attrs \\ %{}) do
    attrs = handle_image(attrs, "photo")

    %Speaker{}
    |> Speaker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a speaker.

  ## Examples

      iex> update_speaker(speaker, %{field: new_value})
      {:ok, %Speaker{}}

      iex> update_speaker(speaker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_speaker(%Speaker{} = speaker, attrs) do
    attrs = handle_image(attrs, "photo")

    speaker
    |> Speaker.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Speaker.

  ## Examples

      iex> delete_speaker(speaker)
      {:ok, %Speaker{}}

      iex> delete_speaker(speaker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_speaker(%Speaker{} = speaker) do
    Repo.delete(speaker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking speaker changes.

  ## Examples

      iex> change_speaker(speaker)
      %Ecto.Changeset{source: %Speaker{}}

  """
  def change_speaker(%Speaker{} = speaker) do
    Speaker.changeset(speaker, %{})
  end

  defp filter_config(:speakers) do
    defconfig do
      text(:name)
      text(:bio)
      text(:topics)
      text(:facebook)
      text(:twitter)
      text(:website)
      text(:instagram)
      # TODO add config for photo of type binary
      boolean(:is_special)
      text(:linkedin)
    end
  end

  defp handle_image(attrs, param) do
    if attrs[param] do
      %Plug.Upload{path: path} = attrs[param]
      filename = Path.basename(path)
      File.copy!(path, Path.expand("priv/static/images/#{filename}"))

      Map.put(attrs, param, filename)
    else
      attrs
    end
  end
end
