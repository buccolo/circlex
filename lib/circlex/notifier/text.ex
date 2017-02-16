defmodule Circlex.Notifier.Text do
  @behaviour Circlex.Notifier

  def status_change(repo, branch, "", initial_status) do
    IO.puts("Watching " <> repo <> " on branch " <> branch)
    IO.puts("Build is currently " <> initial_status)
  end

  def status_change(repo, branch, previous_status, status) do
    IO.puts(repo <> " @ " <> branch <> ": Build is now " <> status <> ", previously it was " <> previous_status)
  end

  def idle, do: IO.puts('.')
end
