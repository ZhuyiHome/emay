defmodule Emay.Mixfile do
  use Mix.Project

  @version "1.0.1"

  def project do
    [app: :emay,
     version: @version,
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [mod: {Emay.Application, []},
     applications: [:logger, :httpoison]]
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
    [{:httpoison, "~> 0.12"},
     {:sweet_xml, "~> 0.6.3"},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    [# These are the default files included in the package
      name: :emay,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Wade Xing"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ZhuyiHome/emay"}]
  end

  defp description do
    """
    Send SM via Emay(亿美软通)
    """
  end
end
