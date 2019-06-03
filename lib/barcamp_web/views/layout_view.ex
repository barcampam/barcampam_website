defmodule BarcampWeb.LayoutView do
  use BarcampWeb, :view

  def current_page?(conn, item) do
    String.contains?(conn.request_path, Routes.page_path(conn, item))
  end

  def current_locale?(conn, locale) do
    String.contains?(conn.request_path, locale)
  end
end
