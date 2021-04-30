defmodule ChatApiWeb.GroupView do
  use ChatApiWeb, :view
  alias ChatApiWeb.{GroupView, FormatHelpers}

  def render("index.json", %{groups: groups}) do
    %{
      groups: render_many(groups, GroupView, "group.json"),
      groupsCount: length(groups)
    }
  end

  def render("show.json", %{group: group}) do
    %{group: render_one(group, GroupView, "group.json")}
  end

  def render("group.json", %{group: group}) do
    group
    |> Map.from_struct()
    |> Map.put(:created_at, datetime_to_iso8601(group.created_at))
    |> Map.put(:updated_at, datetime_to_iso8601(group.updated_at))
    |> Map.take([
      :id,
      :name,
      :created_at,
      :updated_at
    ])
    |> FormatHelpers.camelize()
  end

  defp datetime_to_iso8601(datetime) do
    datetime
    |> Map.put(:microsecond, {elem(datetime.microsecond, 0), 3})
    |> DateTime.to_iso8601()
  end
end
