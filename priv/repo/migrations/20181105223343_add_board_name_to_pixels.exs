defmodule Pixelz.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    alter table(:pixels) do
      add(:board_name, :string, null: true)
    end

    drop(index(:pixels, [:x, :y]))
    create(unique_index(:pixels, [:x, :y, :board_name]))
  end
end
