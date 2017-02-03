defmodule Circlex.Watcher do
  def watch(repo, branch, previous_status \\ "") do
    case Circlex.Checker.check(repo, branch) do
      {:ok, status } ->

        if previous_status != status do
          Circlex.Notifier.status_change(repo, branch, previous_status, status)
        else
          Circlex.Notifier.idle()
        end

        :timer.sleep(5000)
        watch(repo, branch, status)
      {_, message } ->
        IO.puts(message)
    end
  end
end

