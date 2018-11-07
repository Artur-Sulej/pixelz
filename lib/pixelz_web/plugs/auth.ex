defmodule PixelzWeb.Auth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = fetch_user(user_id)
    assign(conn, :current_user, user)
  end

  defp fetch_user(_user_id) do
    %{id: 1337}
  end
end
