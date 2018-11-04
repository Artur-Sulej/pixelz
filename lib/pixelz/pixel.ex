defmodule Pixelz.Pixel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pixels" do
    field(:x, :integer)
    field(:y, :integer)
    field(:color, :string)
  end

  def changeset(pixel, attrs) do
    pixel
    |> cast(attrs, ~w{x y color}a)
    |> validate_required(~w{x y color}a)
  end
end
