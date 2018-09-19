defmodule ApiWeb.TestResolver do
  alias Api.Test
  alias Api.Repo

  def all_messages(_root, _args, %{context: %{current_user: current_user}}) do
    messages = Test.list_messages()
    {:ok, messages}
  end

  def all_messages(_root, _args, _info) do
    messages = Test.list_messages()
    {:error, "Not Authorized"}
  end

  def new_message(_root, args, _info) do
    message = %Test.Message{text: args.text} |> Repo.insert!()
    {:ok, message}
  end
end
