defmodule Calendario.Repo do
  use Ecto.Repo,
    otp_app: :calendario,
    adapter: Ecto.Adapters.Postgres
end
