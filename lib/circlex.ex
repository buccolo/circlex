defmodule Circlex.CLI do
  use ExCLI.DSL, escript: true, mix_task: :circlex

  alias Circlex.Checker
  alias Circlex.Watcher

  name "circlex"
  description "Monitors CircleCI build status"

  command :check do
    description "Checks build status"

    argument :repo, help: "organization/repository the project belongs to"
    argument :branch, help: "branch to check status of"

    run context do
      {_, message } = Checker.check(context.repo, context.branch)
      IO.puts(message)
    end
  end

  command :watch do
    description "Monitors build status"

    argument :repo, help: "organization/repository the project belongs to"
    argument :branch, help: "branch to check status of"

    run context do
      Watcher.watch(context.repo, context.branch)
    end
  end
end
