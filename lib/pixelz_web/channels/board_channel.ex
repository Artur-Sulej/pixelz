defmodule PixelzWeb.BoardChannel do
  use PixelzWeb, :channel

  def join("board:lobby", payload, socket) do
    {:ok, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (board:lobby).
  def handle_in("paint_pixel", payload, socket) do
    broadcast(socket, "paint_pixel", payload)
    {:noreply, socket}
  end
end
