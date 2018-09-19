defmodule ApiWeb.Schema do
  use Absinthe.Schema

  alias ApiWeb.TestResolver

  object :message do
    field(:id, non_null(:id))
    field(:text, non_null(:string))
  end

  object :user do
    field(:id, :id)
    field(:email, :string)
  end

  query do
    field :all_messages, non_null(list_of(non_null(:message))) do
      resolve(&TestResolver.all_messages/3)
    end
  end

  mutation do
    field :new_message, :message do
      arg(:text, non_null(:string))
      resolve(&TestResolver.new_message/3)
    end
  end

  subscription do
    field :new_message, :message do
      arg(:text, non_null(:string))

      config(fn args, _ ->
        {:ok, topic: args.text}
      end)

      trigger(:new_message,
        topic: fn message ->
          message.text
        end
      )

      resolve(fn message, _, _ ->
        {:ok, message}
      end)
    end
  end
end
