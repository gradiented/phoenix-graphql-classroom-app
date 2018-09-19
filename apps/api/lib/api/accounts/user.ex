defmodule Api.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Api.Accounts.UserType
  alias Comeonin.Bcrypt

  schema "users" do
    field(:email, :string)
    field(:encrypted_password, :string)
    field(:password, :string, virtual: true)
    belongs_to(:user_type, UserType)
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, encrypted_password: Bcrypt.hashpwsalt(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
