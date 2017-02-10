defmodule Circlex.Notifier.AnyBar do
  @behaviour Circlex.Notifier

  @default_port 1738
  @status_to_color %{
    "fixed" => "green",
    "success" => "green",
    "running" => "blue",
    "retried" => "blue",
    "canceled" => "orange",
    "failed" => "red",
    "scheduled" => "purple",
    "queued" => "purple",
    "infrastructure_fail" => "exclamation",
    "timedout" => "exclamation",
    "not_run" => "exclamation",
    "not_running" => "exclamation",
    "no_tests" => "exclamation"
  }

  def status_change(_repo, _branch, _, status) do
    AnyBar.change(@status_to_color[status] || "exclamation", @default_port)
  end

  def idle(), do: nil
end
