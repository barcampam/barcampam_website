defmodule BarcampWeb.ErrorView do
  use BarcampWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal server error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, assigns) do
    layout = {BarcampWeb.LayoutView, "app.html"}
    message = Phoenix.Controller.status_message_from_template(template)

    render(__MODULE__, "index.html", Enum.into([layout: layout, message: message], assigns))
  end
end
