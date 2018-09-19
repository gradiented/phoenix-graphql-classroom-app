defmodule ApiWeb.UserResolver do
  alias Api.Accounts
  alias Api.Repo

  def create(params, _info) do
    Accounts.create_user(params)
  end

  def create_user(attrs \\ %{}) do
    %Accounts.User{}
    |> Accounts.User.changeset(attrs)
    |> Repo.insert()
  end

  def login(%{email: email, password: password}, _info) do
    with {:ok, user} <- Accounts.authenticate_user(email, password),
         {:ok, jwt, _} <- Api.Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt}}
    end
  end
end
