defmodule RenameMe.Repo do
  use Ecto.Repo,
    otp_app: :rename_me,
    adapter: Ecto.Adapters.Postgres
end
