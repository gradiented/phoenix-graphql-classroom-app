defmodule ApiWeb.TestResolver do
  alias Api.Test

  def all_messages(_root, _args, _info) do
    messages = Test.list_messages()
    { :ok, messages }
  end
end
