defmodule Circlex.CLI do
  use ExCLI.DSL, escript: true, mix_task: :circlex

  name "circlex"
  description "Monitors CircleCI build status"

  command :check do
    description "Checks build status"

    argument :repo, help: "organization/repository the project belongs to"
    argument :branch, help: "branch to check status of"

    run context do
      {_, message } = Circlex.Checker.check(context.repo, context.branch)
      IO.puts(message)
    end
  end

  command :watch do
    description "Monitors build status"

    argument :repo, help: "organization/repository the project belongs to"
    argument :branch, help: "branch to check status of"

    run context do
      IO.puts "Watching " <> context.repo <> " on branch " <> context.branch
      Circlex.Watcher.watch(context.repo, context.branch)
    end
  end
end
