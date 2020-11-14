defmodule LangEquiv.Repo do
  use Ecto.Repo,
    otp_app: :lang_equiv,
    adapter: Ecto.Adapters.Postgres
end
