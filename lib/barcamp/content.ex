defmodule Barcamp.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Barcamp.Repo
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Barcamp.Content.Faq

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of faqs using filtrex
filters.

## Examples

    iex> list_faqs(%{})
    %{faqs: [%Faq{}], ...}
"""
@spec paginate_faqs(map) :: {:ok, map} | {:error, any}
def paginate_faqs(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:faqs), params["faq"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_faqs(filter, params) do
    {:ok,
      %{
        faqs: page.entries,
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

defp do_paginate_faqs(filter, params) do
  Faq
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of faqs.

## Examples

    iex> list_faqs()
    [%Faq{}, ...]

"""
def list_faqs do
  Repo.all(Faq)
end

@doc """
Gets a single faq.

Raises `Ecto.NoResultsError` if the Faq does not exist.

## Examples

    iex> get_faq!(123)
    %Faq{}

    iex> get_faq!(456)
    ** (Ecto.NoResultsError)

"""
def get_faq!(id), do: Repo.get!(Faq, id)

@doc """
Creates a faq.

## Examples

    iex> create_faq(%{field: value})
    {:ok, %Faq{}}

    iex> create_faq(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_faq(attrs \\ %{}) do
  %Faq{}
  |> Faq.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a faq.

## Examples

    iex> update_faq(faq, %{field: new_value})
    {:ok, %Faq{}}

    iex> update_faq(faq, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_faq(%Faq{} = faq, attrs) do
  faq
  |> Faq.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a Faq.

## Examples

    iex> delete_faq(faq)
    {:ok, %Faq{}}

    iex> delete_faq(faq)
    {:error, %Ecto.Changeset{}}

"""
def delete_faq(%Faq{} = faq) do
  Repo.delete(faq)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking faq changes.

## Examples

    iex> change_faq(faq)
    %Ecto.Changeset{source: %Faq{}}

"""
def change_faq(%Faq{} = faq) do
  Faq.changeset(faq, %{})
end

defp filter_config(:faqs) do
  defconfig do
    text :question_eng
      text :question_arm
      text :answer_eng
      text :answer_arm
      
  end
end
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Barcamp.Content.About

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of abouts using filtrex
filters.

## Examples

    iex> list_abouts(%{})
    %{abouts: [%About{}], ...}
"""
@spec paginate_abouts(map) :: {:ok, map} | {:error, any}
def paginate_abouts(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:abouts), params["about"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_abouts(filter, params) do
    {:ok,
      %{
        abouts: page.entries,
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

defp do_paginate_abouts(filter, params) do
  About
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of abouts.

## Examples

    iex> list_abouts()
    [%About{}, ...]

"""
def list_abouts do
  Repo.all(About)
end

@doc """
Gets a single about.

Raises `Ecto.NoResultsError` if the About does not exist.

## Examples

    iex> get_about!(123)
    %About{}

    iex> get_about!(456)
    ** (Ecto.NoResultsError)

"""
def get_about!(id), do: Repo.get!(About, id)

@doc """
Creates a about.

## Examples

    iex> create_about(%{field: value})
    {:ok, %About{}}

    iex> create_about(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_about(attrs \\ %{}) do
  %About{}
  |> About.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a about.

## Examples

    iex> update_about(about, %{field: new_value})
    {:ok, %About{}}

    iex> update_about(about, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_about(%About{} = about, attrs) do
  about
  |> About.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a About.

## Examples

    iex> delete_about(about)
    {:ok, %About{}}

    iex> delete_about(about)
    {:error, %Ecto.Changeset{}}

"""
def delete_about(%About{} = about) do
  Repo.delete(about)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking about changes.

## Examples

    iex> change_about(about)
    %Ecto.Changeset{source: %About{}}

"""
def change_about(%About{} = about) do
  About.changeset(about, %{})
end

defp filter_config(:abouts) do
  defconfig do
    text :text_eng
      text :text_arm
      
  end
end
end
