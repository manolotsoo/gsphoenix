defmodule Gsphoenix.Repo do
  use Ecto.Repo,
    otp_app: :gsphoenix,
    adapter: Ecto.Adapters.MyXQL
end
