defmodule Api.Guardian do
  use Guardian, otp_app: :api
  alias Api.Accounts

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(claims) do
    user = claims["sub"] |> Accounts.get_user!()
    {:ok, user}
  end
end
