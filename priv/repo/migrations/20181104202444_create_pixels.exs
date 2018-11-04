defmodule Pixelz.Repo.Migrations.CreatePixels do
  use Ecto.Migration

  def change do
    create table(:pixels) do
      add(:x, :integer, null: false)
      add(:y, :integer, null: false)
      add(:color, :string, null: false)
    end

    create(unique_index(:pixels, [:x, :y]))
  end
end
