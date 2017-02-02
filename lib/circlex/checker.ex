defmodule Circlex.Checker do
  def check(repo, branch) do
    token = System.get_env("CIRCLECI_TOKEN")
    url = "https://circleci.com/api/v1.1/project/github/" <> repo <> "/tree/" <> branch <> "?circle-token=" <> token <> "&limit=1"

    HTTPoison.start
    case HTTPoison.get(url, %{Accept: "application/json"}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        [%{"status" => status}] = Poison.Parser.parse!(body)

        {:ok, status}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end
end
