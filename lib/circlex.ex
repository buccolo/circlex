defmodule Circlex.CLI do
  use ExCLI.DSL, escript: true, mix_task: :circlex

  name "circlex"
  description "Monitors CircleCI build status"

  command :check do
    description "Checks build status"

    argument :repo, help: "organization/repository the project belongs to"
    argument :branch, help: "branch to check status of"

    run context do

      repo = context.repo
      token = System.get_env("CIRCLECI_TOKEN")
      url = "https://circleci.com/api/v1.1/project/github/" <> repo <> "/tree/" <> context.branch <> "?circle-token=" <> token <> "&limit=1"

      HTTPoison.start
      case HTTPoison.get(url, %{Accept: "application/json"}) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          decode(body)
        {:ok, %HTTPoison.Response{status_code: 404}} ->
          IO.puts "Not found :("
        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect reason
      end
    end
  end

  defp decode(response) do
    [%{"outcome" => outcome, "status" => status}] = Poison.Parser.parse!(response)

    IO.puts "Status: " <> status
    IO.puts "Outcome: " <> outcome
  end
end
