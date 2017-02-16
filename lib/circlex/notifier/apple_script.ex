defmodule Circlex.Notifier.AppleScript do
  @behaviour Circlex.Notifier

  def status_change(repo, branch, "", initial_status) do
    notify(title(repo, branch), "Build is " <> initial_status)
  end

  def status_change(repo, branch, previous_status, status) do
    notify(title(repo, branch), "Build is now " <> status <> ", previously it was " <> previous_status)
  end

  def idle, do: nil

  defp title(repo, branch) do
    repo <> " @ " <> branch
  end

  defp notify(title, message) do
    display_command = "display notification \"" <> message <> ".\" with title \"" <> title <> ".\""
    System.cmd("osascript", ["-e", String.to_charlist(display_command)], [stderr_to_stdout: true])
  end
end
