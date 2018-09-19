defmodule Api.Guardian do
  use Guardian, otp_app: :api

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(claims) do
    {:ok, %{id: claims["sub"]}}
    # If something goes wrong here return {:error, reason}
  end
end
