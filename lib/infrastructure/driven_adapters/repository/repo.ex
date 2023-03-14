defmodule MatricularCursoCa.Infrastructure.Adapters.Repository.Repo do
  use Ecto.Repo,
  otp_app: :matricular_curso_ca,
  adapter: Ecto.Adapters.Postgres
end
