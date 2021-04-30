defmodule ChatApiWeb.Guardian do
  @moduledoc """
  This module is required by Guardian, to implements all type or configuration for
  the auth token.

  Also, is used to retrieve and deliver the authentication subject to Guardian.

  More details here: https://github.com/ueberauth/guardian#installation
  """

  use Guardian, otp_app: :chat_api

  alias ChatApi.{Repo, Authentication.User}

  def subject_for_token(%User{} = user, _claims), do: {:ok, to_string(user.id)}
  def subject_for_token(_, _), do: {:error, "Unknown resource type"}

  def resource_from_claims(%{"sub" => user_id}), do: {:ok, Repo.get(User, user_id)}
  def resource_from_claims(_claims), do: {:error, "Unknown resource type"}
end
