defmodule PixelzWeb.BoardChannel do
  use PixelzWeb, :channel
  alias Pixelz.{Pixel, Repo}
  import Ecto.Query

  def join("board:" <> board_name, payload, socket) do
    send(self(), :after_join)
    {:ok, assign(socket, :board_name, board_name)}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (board:lobby).
  def handle_in("paint_pixel", payload, socket) do
    upsert_pixel(payload, socket.assigns.board_name)
    broadcast(socket, "paint_pixel", payload)
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    payload = %{pixels: fetch_pixels(socket.assigns.board_name)}
    push(socket, "paint_pixels", payload)
    {:noreply, socket}
  end

  defp upsert_pixel(payload = %{"x" => x, "y" => y, "color" => color}, board_name) do
    pixel = Repo.get_by(Pixel, x: x, y: y, board_name: board_name)

    case pixel do
      nil ->
        %Pixel{}
        |> Pixel.changeset(Map.put(payload, "board_name", board_name))
        |> Repo.insert()

      pixel ->
        pixel
        |> Pixel.changeset(%{"color" => color})
        |> Repo.update()
    end
  end

  defp fetch_pixels(board_name) do
    query = from(pixels in Pixel, where: [board_name: ^board_name])

    query
    |> Repo.all()
    |> Enum.map(&Map.take(&1, [:x, :y, :color]))
  end
end
