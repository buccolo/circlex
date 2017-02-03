defmodule Circlex.Mixfile do
  use Mix.Project

  def project do
    [app: :circlex,
     description: "Monitors CircleCI builds",
     package: package(),
     version: "0.1.0",
     elixir: "~> 1.3",
     escript: [main_module: Circlex.CLI],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_cli, "~> 0.1.0"},
    {:httpoison, "~> 0.10.0"},
    {:poison, "~> 3.0"},
    {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    [ licenses: ["MIT"],
      maintainers: ["Bruno Buccolo"],
      links: %{"GitHub" => "https://github.com/buccolo/circlex"} ]
  end
end
