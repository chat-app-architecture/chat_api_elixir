defmodule ChatApiWeb.GroupMessageView do
  use ChatApiWeb, :view
  alias ChatApiWeb.{GroupMessageView, FormatHelpers}

  def render("show.json", %{group_message: group_message}) do
    %{group_message: render_one(group_message, GroupMessageView, "group_message.json")}
  end

  def render("group_message.json", %{group_message: group_message}) do
    group_message
    |> Map.from_struct()
    |> Map.take([
      :id,
      :message,
      :group_id,
      :user_id
    ])
    |> FormatHelpers.camelize()
  end

  defp datetime_to_iso8601(datetime) do
    datetime
    |> Map.put(:microsecond, {elem(datetime.microsecond, 0), 3})
    |> DateTime.to_iso8601()
  end
end
