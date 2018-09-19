defmodule ApiWeb.Schema do
  use Absinthe.Schema

  alias ApiWeb.TestResolver
  alias ApiWeb.UserResolver

  object :message do
    field(:id, non_null(:id))
    field(:text, non_null(:string))
  end

  object :user do
    field(:id, :id)
    field(:email, :string)
  end

  object :session do
    field(:token, :string)
  end

  query do
    field :all_messages, non_null(list_of(non_null(:message))) do
      resolve(&TestResolver.all_messages/3)
    end

    field :login, type: :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&UserResolver.login/2)
    end
  end

  mutation do
    field :new_message, :message do
      arg(:text, non_null(:string))
      resolve(&TestResolver.new_message/3)
    end

    field :create_user, type: :user do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&UserResolver.create/2)
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
