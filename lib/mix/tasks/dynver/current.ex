defmodule Mix.Tasks.Dynver.Current do
  use Mix.Task

  @shortdoc "Find the current version number"
  def run(_args) do
    IO.puts DynamicVersions.version
  end
end
