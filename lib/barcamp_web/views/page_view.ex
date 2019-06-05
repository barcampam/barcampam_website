defmodule BarcampWeb.PageView do
  use BarcampWeb, :view

  def sort_talks(talks) do
    Enum.sort(talks, fn x, y ->
      case Time.compare(x.time_from, y.time_from) do
        :lt -> true
        _ -> false
      end
    end)
  end

  def render_doc(doc) do
    doc
    |> Earmark.as_html!()
    |> raw()
  end
end
