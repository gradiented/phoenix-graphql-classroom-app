defmodule ApiWeb.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  @doc """
  Return the current user context based on the authorization header
  """
  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization") do
      with {:ok, claims} <- Api.Guardian.decode_and_verify(token),
           {:ok, current_user} <- Api.Guardian.resource_from_claims(claims) do
        %{current_user: current_user}
      end
    else
      none -> %{}
    end
  end
end
