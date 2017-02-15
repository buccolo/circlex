defmodule Circlex.Checker do
  alias HTTPoison.Response
  alias Poison.Parser

  def check(repo, branch) do
    HTTPoison.start

    handle_response HTTPoison.get(url(repo, branch), %{Accept: "application/json"})
  end

  defp token do
    System.get_env("CIRCLECI_TOKEN") || throw "You need to set a CIRCLECI_TOKEN environment variable"
  end

  defp url(repo, branch) do
    "https://circleci.com/api/v1.1/project/github/" <> repo <> "/tree/" <> branch <> "?circle-token=" <> token() <> "&limit=1"
  end

  defp handle_response({:ok, %Response{status_code: 404, body: _}}), do: {:error, "Project was not found"}
  defp handle_response({:ok, %Response{status_code: 200, body: body}}) do
    parse_response Parser.parse!(body)
  end

  defp parse_response([%{"status" => status}]), do: {:ok, status}
  defp parse_response(_), do: {:error, "Branch was not found"}
end
