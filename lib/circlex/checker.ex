defmodule Circlex.Checker do
  def check(repo, branch) do
    HTTPoison.start

    case HTTPoison.get(url(repo, branch), %{Accept: "application/json"}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        handle_response(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Project was not found" }
      {:error, %HTTPoison.Error{}} ->
        {:error, "Something weird just happened" }
    end
  end

  defp token do
    Application.get_env(:circlex, :token) || throw "You need to set a CIRCLECI_TOKEN environment variable"
  end

  defp url(repo, branch) do
    "https://circleci.com/api/v1.1/project/github/" <> repo <> "/tree/" <> branch <> "?circle-token=" <> token() <> "&limit=1"
  end

  defp handle_response(body) do
    case Poison.Parser.parse!(body) do
      [%{"status" => status}] -> {:ok, status}
      _ -> {:error, "Branch was not found" }
    end
  end
end
