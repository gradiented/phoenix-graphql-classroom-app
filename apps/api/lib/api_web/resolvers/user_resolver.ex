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
end
