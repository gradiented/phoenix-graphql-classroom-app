alias Api.Test.Message
alias Api.Repo

%Message{ text: "Hello GraphQL" } |> Repo.insert!
