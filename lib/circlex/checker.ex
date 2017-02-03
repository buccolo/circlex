defmodule Circlex.Checker do
  def check(repo, branch) do
    token = System.get_env("CIRCLECI_TOKEN")
    url = "https://circleci.com/api/v1.1/project/github/" <> repo <> "/tree/" <> branch <> "?circle-token=" <> token <> "&limit=1"

    HTTPoison.start
    case HTTPoison.get(url, %{Accept: "application/json"}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        handle_response(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Project was not found" }
      {:error, %HTTPoison.Error{}} ->
        {:error, "Something weird just happened" }
    end
  end

  defp handle_response(body) do
    case Poison.Parser.parse!(body) do
      [%{"status" => status}] -> {:ok, status}
      _ -> {:error, "Branch was not found" }
    end
  end
end
