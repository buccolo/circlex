defmodule Circlex.Watcher do
  def watch(repo, branch, previous_status \\ "") do
    {:ok, status } = Circlex.Checker.check(repo, branch)

    if previous_status != status do
      Circlex.Notifier.status_change(repo, branch, previous_status, status)
    else
      Circlex.Notifier.idle()
    end

    :timer.sleep(5000)
    watch(repo, branch, status)
  end
end

