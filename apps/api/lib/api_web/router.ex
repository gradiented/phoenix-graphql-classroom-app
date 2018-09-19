defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(ApiWeb.Context)
  end

  scope "/api" do
    pipe_through(:api)

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: ApiWeb.Schema,
      interface: :playground,
      socket: ApiWeb.UserSocket,
      context: %{pubsub: ApiWeb.Endpoint}
    )
  end
end
