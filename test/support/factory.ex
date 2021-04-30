defmodule ChatApi.Factory do
  use ExMachina.Ecto, repo: ChatApi.Repo

  def user_factory do
    %ChatApi.Authentication.User{
      email: Faker.Internet.email(),
      password: "some password"
    }
  end

  def user_resource_factory do
    %ChatApi.Authentication.UserResource{
      user: build(:user),
      user_resource_type: "group_message",
      user_resource_id: "1"
    }
  end

  def group_factory do
    %ChatApi.Chat.Group{
      name: Faker.Lorem.sentence()
    }
  end

  def group_message_factory do
    %ChatApi.Chat.GroupMessage{
      message: Faker.Lorem.sentence(),
      group: build(:group),
      user_id: "1"
    }
  end
end
