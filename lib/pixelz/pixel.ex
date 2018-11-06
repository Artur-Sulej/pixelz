defmodule Pixelz.Pixel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pixels" do
    field(:x, :integer)
    field(:y, :integer)
    field(:color, :string)
    field(:board_name, :string)
  end

  def changeset(pixel, attrs) do
    pixel
    |> cast(attrs, ~w{x y color board_name}a)
    |> validate_required(~w{x y color board_name}a)
  end
end
