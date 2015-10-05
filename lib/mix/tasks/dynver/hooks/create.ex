defmodule Mix.Tasks.Dynver.Hooks.Create do
  use Mix.Task

  @shortdoc "Create git repo hooks to facilitate pulling version from `git describe`"
  def run(_args) do
    Mix.shell.info "Creating git post-commit hook"
    create_executeable_file(".git/hooks/post-commit")

    Mix.shell.info "Creating git post-checkout hook"
    create_executeable_file(".git/hooks/post-checkout")
  end

  defp create_executeable_file(path, content \\ hook_content) do
    File.write(path, content)
    File.chmod(path, 555)
  end

  defp hook_content do
    """
    #!/bin/bash
    `git describe > VERSION`
    """
  end

end
