defmodule DynamicVersions do
  def version(preference_list \\ [:file, :git]) do
    preference_list
    |> Enum.find_value("UNKNOWN", fn type -> type |> version_from |> handle_version end )
  end

  def version_from(:file) do
    File.read("VERSION")
    |> case do
      {:ok, content} -> {:ok, String.strip(content)}
      results -> {:error, {:file, results}}
    end 
  end

  def version_from(:git) do
    require Logger
    Logger.warn "Calling `git describe` for version number is slow! Consider using `mix dynver.hooks.create` to create git hooks."
    System.cmd("git", ["describe", "--always", "--tags"])
    |> case do
      {content, 0} -> {:ok, String.strip(content)}
      results -> {:error, {:git, results}}
    end
  end

  def handle_version({:ok, version}) do
    version
    |> String.split("-")
    |> case do
      [tag] -> tag
      [tag, _num_commits, sha] -> "#{tag}-#{sha}"
    end
  end
  def handle_version(_), do: nil 

end
