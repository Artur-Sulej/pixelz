defmodule PixelzWeb.BoardChannel do
  use PixelzWeb, :channel
  alias Pixelz.{Pixel, Repo}

  def join("board:lobby", payload, socket) do
    {:ok, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (board:lobby).
  def handle_in("paint_pixel", payload, socket) do
    upsert_pixel(payload)
    broadcast(socket, "paint_pixel", payload)
    {:noreply, socket}
  end

  defp upsert_pixel(payload = %{"x" => x, "y" => y, "color" => color}) do
    pixel = Repo.get_by(Pixel, x: x, y: y)

    case pixel do
      nil ->
        %Pixel{}
        |> Pixel.changeset(payload)
        |> Repo.insert()

      pixel ->
        pixel
        |> Pixel.changeset(%{"color" => color})
        |> Repo.update()
    end
  end
end
