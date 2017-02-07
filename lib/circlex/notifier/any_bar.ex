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
    IO.puts(status)
    AnyBar.change(@status_to_color[status] || "exclamation", 1738)
  end

  def idle() do
    IO.puts('.')
  end
end
