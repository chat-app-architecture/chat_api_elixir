# Chat API in Phoenix

This codebase was created to demonstrate a fully fledged backend API with **Elixir and Phoenix** including CRUD operations, authentication, routing, pagination, and more.

- [Chat API in Phoenix](#chat-api-in-phoenix)
  - [Installation](#installation)
  - [API Endpoints](#api-endpoints)
  - [Tests](#tests)
  - [Style guide](#style-guide)
  - [Licensing](#licensing)

## Installation

To run this project, you will need to install the following dependencies on your system:

* [Elixir](https://elixir-lang.org/install.html)
* [Phoenix](https://hexdocs.pm/phoenix/installation.html)
* [PostgreSQL](https://www.postgresql.org/download/macosx/)

To get started, run the following commands in your project folder:

| Command                                       | Description                                  |
|-----------------------------------------------|----------------------------------------------|
| `mix deps.get`                                | installs the dependencies                    |
| `mix ecto.create`                             | creates the database                         |
| `mix ecto.migrate`                            | run the database migrations                  |
| `mix phx.server`                              | run the application                          |

This is a backend project, you won't be able to go to `localhost:4000` and see a Frontend application. You can test the API endpoint using Postman or Insomnia.

## API Endpoints

| Endpoint                    | Controller                          | Action       | HTTP method  |
|-----------------------------|-------------------------------------|--------------|--------------|
| `/groups`                   | ChatApiWeb.GroupController          | index        | GET          |
| `/groups/:id`               | ChatApiWeb.GroupController          | show         | GET          |
| `/groups`                   | ChatApiWeb.GroupController          | create       | POST         |
| `/groups/:id`               | ChatApiWeb.GroupController          | put/patch    | PUT/PATCH    |
| `/groups/:id`               | ChatApiWeb.GroupController          | delete       | DELETE       |
| `/group_messages`           | ChatApiWeb.GroupMessageController   | index        | GET          |
| `/group_messages/:id`       | ChatApiWeb.GroupMessageController   | show         | GET          |
| `/group_messages`           | ChatApiWeb.GroupMessageController   | create       | POST         |
| `/group_messages/:id`       | ChatApiWeb.GroupMessageController   | put/patch    | PUT/PATCH    |
| `/group_messages/:id`       | ChatApiWeb.GroupMessageController   | delete       | DELETE       |
| `/user`                     | ChatApiWeb.UserController           | current_user | GET          |
| `/users`                    | ChatApiWeb.UserController           | create       | POST         |
| `/users/sign_in`            | ChatApiWeb.SessionController        | create       | POST         |

## Tests

To run the tests for this project, simply run in your terminal:

```shell
mix test
```

## Style guide

This project uses [mix format](https://hexdocs.pm/mix/master/Mix.Tasks.Format.html). You can find the configuration file for the formatter in the `.formatter.exs` file.

## Licensing

MIT © Vitor Oliveira
