defmodule ApiWeb.Schema do
  use Absinthe.Schema

  alias ApiWeb.TestResolver

  object :message do
    field :id, non_null(:id)
    field :text, non_null(:string)
  end

  query do
    field :all_messages, non_null(list_of(non_null(:message))) do
      resolve &TestResolver.all_messages/3
    end
  end

end
