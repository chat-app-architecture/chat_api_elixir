defmodule ChatApiWeb.Router do
  use ChatApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(ProperCase.Plug.SnakeCaseParams)

    plug(
      Guardian.Plug.Pipeline,
      error_handler: ChatApiWeb.SessionController,
      module: ChatApiWeb.Guardian
    )

    plug(Guardian.Plug.VerifyHeader, realm: "Token")
    plug(Guardian.Plug.LoadResource, allow_blank: true)
  end

  scope "/", ChatApiWeb do
    pipe_through(:api)

    resources("/groups", GroupController, except: [:new, :edit])
    resources("/group_messages", GroupMessageController, except: [:new, :edit])

    get("/user", UserController, :current_user)
    put("/user", UserController, :update)
    post("/users", UserController, :create)
    post("/users/sign_in", SessionController, :create)
  end
end
