defmodule ApiWeb.Schema do
  use Absinthe.Schema

  alias ApiWeb.TestResolver

  object :message do
    field(:id, non_null(:id))
    field(:text, non_null(:string))
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

      # The topic function is used to determine what topic a given subscription
      # cares about based on its arguments. You can think of it as a way to tell the
      # difference between
      # subscription {
      #   commentAdded(repoName: "absinthe-graphql/absinthe") { content }
      # }
      #
      # and
      #
      # subscription {
      #   commentAdded(repoName: "elixir-lang/elixir") { content }
      # }
      config(fn args, _ ->
        {:ok, topic: args.text}
      end)

      # this tells Absinthe to run any subscriptions with this field every time
      # the :submit_comment mutation happens.
      # It also has a topic function used to find what subscriptions care about
      # this particular comment
      trigger(:new_message,
        topic: fn message ->
          message.text
        end
      )

      resolve(fn message, _, _ ->
        # this function is often not actually necessary, as the default resolver
        # for subscription functions will just do what we're doing here.
        # The point is, subscription resolvers receive whatever value triggers
        # the subscription, in our case a comment.
        {:ok, message}
      end)
    end
  end
end
