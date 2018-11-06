defmodule Mix.Tasks.Destroy do
  use Mix.Task

  alias Pixelz.{
    Pixel,
    Repo
  }

  def run(_) do
    Mix.Ecto.ensure_started(Repo, [])
    Repo.delete_all(Pixel)
  end
end
