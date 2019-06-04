defmodule Barcamp.Logos do
  @moduledoc """
  The Logos context.
  """

  import Ecto.Query, warn: false
  alias Barcamp.Repo
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Barcamp.Logos.Sponsor

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of sponsors using filtrex
filters.

## Examples

    iex> list_sponsors(%{})
    %{sponsors: [%Sponsor{}], ...}
"""
@spec paginate_sponsors(map) :: {:ok, map} | {:error, any}
def paginate_sponsors(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:sponsors), params["sponsor"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_sponsors(filter, params) do
    {:ok,
      %{
        sponsors: page.entries,
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

defp do_paginate_sponsors(filter, params) do
  Sponsor
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of sponsors.

## Examples

    iex> list_sponsors()
    [%Sponsor{}, ...]

"""
def list_sponsors do
  Repo.all(Sponsor)
end

@doc """
Gets a single sponsor.

Raises `Ecto.NoResultsError` if the Sponsor does not exist.

## Examples

    iex> get_sponsor!(123)
    %Sponsor{}

    iex> get_sponsor!(456)
    ** (Ecto.NoResultsError)

"""
def get_sponsor!(id), do: Repo.get!(Sponsor, id)

@doc """
Creates a sponsor.

## Examples

    iex> create_sponsor(%{field: value})
    {:ok, %Sponsor{}}

    iex> create_sponsor(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_sponsor(attrs \\ %{}) do
  %Sponsor{}
  |> Sponsor.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a sponsor.

## Examples

    iex> update_sponsor(sponsor, %{field: new_value})
    {:ok, %Sponsor{}}

    iex> update_sponsor(sponsor, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_sponsor(%Sponsor{} = sponsor, attrs) do
  sponsor
  |> Sponsor.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a Sponsor.

## Examples

    iex> delete_sponsor(sponsor)
    {:ok, %Sponsor{}}

    iex> delete_sponsor(sponsor)
    {:error, %Ecto.Changeset{}}

"""
def delete_sponsor(%Sponsor{} = sponsor) do
  Repo.delete(sponsor)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking sponsor changes.

## Examples

    iex> change_sponsor(sponsor)
    %Ecto.Changeset{source: %Sponsor{}}

"""
def change_sponsor(%Sponsor{} = sponsor) do
  Sponsor.changeset(sponsor, %{})
end

defp filter_config(:sponsors) do
  defconfig do
     #TODO add config for logo of type binary
    
  end
end
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Barcamp.Logos.General

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of generals using filtrex
filters.

## Examples

    iex> list_generals(%{})
    %{generals: [%General{}], ...}
"""
@spec paginate_generals(map) :: {:ok, map} | {:error, any}
def paginate_generals(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:generals), params["general"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_generals(filter, params) do
    {:ok,
      %{
        generals: page.entries,
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

defp do_paginate_generals(filter, params) do
  General
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of generals.

## Examples

    iex> list_generals()
    [%General{}, ...]

"""
def list_generals do
  Repo.all(General)
end

@doc """
Gets a single general.

Raises `Ecto.NoResultsError` if the General does not exist.

## Examples

    iex> get_general!(123)
    %General{}

    iex> get_general!(456)
    ** (Ecto.NoResultsError)

"""
def get_general!(id), do: Repo.get!(General, id)

@doc """
Creates a general.

## Examples

    iex> create_general(%{field: value})
    {:ok, %General{}}

    iex> create_general(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_general(attrs \\ %{}) do
  %General{}
  |> General.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a general.

## Examples

    iex> update_general(general, %{field: new_value})
    {:ok, %General{}}

    iex> update_general(general, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_general(%General{} = general, attrs) do
  general
  |> General.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a General.

## Examples

    iex> delete_general(general)
    {:ok, %General{}}

    iex> delete_general(general)
    {:error, %Ecto.Changeset{}}

"""
def delete_general(%General{} = general) do
  Repo.delete(general)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking general changes.

## Examples

    iex> change_general(general)
    %Ecto.Changeset{source: %General{}}

"""
def change_general(%General{} = general) do
  General.changeset(general, %{})
end

defp filter_config(:generals) do
  defconfig do
     #TODO add config for logo of type binary
    
  end
end
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Barcamp.Logos.Partner

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of partners using filtrex
filters.

## Examples

    iex> list_partners(%{})
    %{partners: [%Partner{}], ...}
"""
@spec paginate_partners(map) :: {:ok, map} | {:error, any}
def paginate_partners(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:partners), params["partner"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_partners(filter, params) do
    {:ok,
      %{
        partners: page.entries,
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

defp do_paginate_partners(filter, params) do
  Partner
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of partners.

## Examples

    iex> list_partners()
    [%Partner{}, ...]

"""
def list_partners do
  Repo.all(Partner)
end

@doc """
Gets a single partner.

Raises `Ecto.NoResultsError` if the Partner does not exist.

## Examples

    iex> get_partner!(123)
    %Partner{}

    iex> get_partner!(456)
    ** (Ecto.NoResultsError)

"""
def get_partner!(id), do: Repo.get!(Partner, id)

@doc """
Creates a partner.

## Examples

    iex> create_partner(%{field: value})
    {:ok, %Partner{}}

    iex> create_partner(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_partner(attrs \\ %{}) do
  %Partner{}
  |> Partner.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a partner.

## Examples

    iex> update_partner(partner, %{field: new_value})
    {:ok, %Partner{}}

    iex> update_partner(partner, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_partner(%Partner{} = partner, attrs) do
  partner
  |> Partner.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a Partner.

## Examples

    iex> delete_partner(partner)
    {:ok, %Partner{}}

    iex> delete_partner(partner)
    {:error, %Ecto.Changeset{}}

"""
def delete_partner(%Partner{} = partner) do
  Repo.delete(partner)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking partner changes.

## Examples

    iex> change_partner(partner)
    %Ecto.Changeset{source: %Partner{}}

"""
def change_partner(%Partner{} = partner) do
  Partner.changeset(partner, %{})
end

defp filter_config(:partners) do
  defconfig do
     #TODO add config for logo of type binary
    
  end
end
end
