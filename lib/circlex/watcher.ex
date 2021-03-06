defmodule Circlex.Watcher do
  alias Circlex.Checker

  @default_notifiers [Circlex.Notifier.Text, Circlex.Notifier.AppleScript, Circlex.Notifier.AnyBar]

  @spec watch(String.t, String.t, String.t, [atom]) :: any
  def watch(repo, branch, previous_status \\ "", notifiers \\ @default_notifiers) do
    case Checker.check(repo, branch) do
      {:ok, status} ->

        if previous_status != status do
          Enum.map(notifiers, &(&1.status_change(repo, branch, previous_status, status)))
        else
          Enum.map(notifiers, &(&1.idle()))
        end

        :timer.sleep(5000)
        watch(repo, branch, status, notifiers)
      {_, message} ->
        IO.puts(message)
    end
  end
end
