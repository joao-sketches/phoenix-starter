defmodule PhoenixStarter.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phoenix_starter,
      version: "0.0.1",
      elixir: "~> 1.2",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases,
      deps: deps
    ]
  end

  def application do
    [
      mod: {PhoenixStarter, []},
      applications: applications(Mix.env)
    ]
  end

  def applications(env) when env in [:test] do
    applications(:default) ++ [:ex_machina]
  end

  def applications(_) do
    [
      :comeonin,
      :cowboy,
      :logger,
      :oauth2,
      :phoenix,
      :phoenix_ecto,
      :phoenix_html,
      :postgrex,
      :ueberauth_github,
      :ueberauth_identity,
      :ueberauth_slack,
      :ueberauth_google,
      :ueberauth_facebook,
      :ueberauth_twitter,
      :ueberauth_fitbit,
      :gettext
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [
      {:ex_machina, "~>0.6", only: [:dev, :test]},
      {:phoenix, "~> 1.1.4"},
      {:phoenix_ecto, "~> 2.0"},
      {:postgrex, ">= 0.0.0", override: true},
      {:phoenix_html, "~> 2.5"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:guardian_db, "0.4.0"},
      {:guardian, "0.9.0"},
      {:ueberauth, git: "https://github.com/ueberauth/ueberauth.git", override: true},
      {:ueberauth_github, "~>0.2.0"},
      {:ueberauth_identity, "~>0.2.1"},
      {:ueberauth_slack, "~>0.2.0"},
      {:ueberauth_google, "~> 0.2"},
      {:ueberauth_facebook, "~> 0.3.2"},
      {:ueberauth_twitter, "~> 0.2"},
      {:ueberauth_fitbit, "~> 0.2"},
      {:oauth, github: "tim/erlang-oauth"},
      {:comeonin, "~> 1.6"},
      {:cowboy, "~> 1.0"},
      {:gettext, "~> 0.9"},
      {:exometer_core, github: "PSPDFKit-labs/exometer_core", override: true},
      {:exometer, github: "PSPDFKit-labs/exometer"},
      {:edown, github: "uwiger/edown", tag: "0.7", override: true}
    ]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     test: [&setup_db/1, "test"]]
  end

  defp setup_db(_) do
    # Create the database, run migrations
    Mix.Task.run "ecto.drop"#, ["--quiet"]
    Mix.Task.run "ecto.create"#, ["--quiet"]
    Mix.Task.run "ecto.migrate"#, ["--quiet"]
  end
end
