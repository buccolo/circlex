defmodule Circlex.Watcher do
  def watch(repo, branch, previous_status \\ "") do
    {:ok, status } = Circlex.Checker.check(repo, branch)

    if previous_status != status do
      IO.puts previous_status <> " -> " <> status
    else
      IO.puts "."
    end

    :timer.sleep(1000)
    watch(repo, branch, status)
  end
end
