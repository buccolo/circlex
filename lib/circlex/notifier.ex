defmodule Circlex.Notifier do
  def status_change(repo, branch, "", initial_status) do
    notify("Build is " <> initial_status)
  end

  def status_change(repo, branch, previous_status, status) do
    notify("Build is now " <> status <> ", previously it was " <> previous_status)
  end

  def idle() do
    IO.puts('.')
  end

  defp notify(message) do
    display_command = "display notification \"" <> message <> ".\""
    System.cmd("osascript", ["-e", String.to_charlist(display_command)], [stderr_to_stdout: true])
  end
end
