defmodule ChatApiWeb.GuardedController do
  @moduledoc """
  Use this module in a controller to take the advantage of having
  the subject of authentication (eg.: an authenticated user) injected
  in the action as the third argument.

  ## Usage example

  defmodule ChatApiWeb.MyController do
    use ChatApiWeb, :controller
    use ChatApiWeb.GuardedController

    plug Guardian.Plug.EnsureAuthenticated

    def index(conn, params, current_user) do
      # ..code..
    end
  end
  """

  defmacro __using__(_opts \\ []) do
    quote do
      def action(conn, _opts) do
        apply(__MODULE__, action_name(conn), [
          conn,
          conn.params,
          ChatApiWeb.Guardian.Plug.current_resource(conn)
        ])
      end
    end
  end
end
