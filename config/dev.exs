import Config

config :matricular_curso_ca, timezone: "America/Bogota"

config :matricular_curso_ca,
       http_port: 8083,
       enable_server: true,
       secret_name: "",
       region: "",
       version: "0.0.1",
       in_test: false,
       custom_metrics_prefix_name: "matricular_curso_ca_local"

config :logger,
       level: :debug

config :matricular_curso_ca, ecto_repos: [MatricularCursoCa.Infrastructure.Adapters.Repository.Repo]

config :matricular_curso_ca, MatricularCursoCa.Infrastructure.Adapters.Repository.Repo,
       database: "matriculaca",
       username: "postgres",
       password: "postgres",
       hostname: "localhost",
       port: 5432,
       show_sensitive_data_on_connection_error: true,
       pool_size: 10

config :matricular_curso_ca, :rabbitmq,
       hostname: "localhost",
       port: 5672,
       username: "guest",
       password: "guest",
       virtual_host: "/"


# detalle de los adaptadores que vamos a usar en nuestro proyecto
config :matricular_curso_ca,
        estudiante_behaviour: MatricularCursoCa.Infrastructure.Adapters.Repository.Estudiante.EstudianteDataRepository,
        curso_behaviour: MatricularCursoCa.Infrastructure.Adapters.Repository.Curso.CursoDataRepository,
        estudiante_curso_behaviour: MatricularCursoCa.Infrastructure.Adapters.Repository.EstudianteCurso.EstudianteCursoDataRepository,
        generate_uuid_behaviour: MatricularCursoCa.Infrastructure.DrivenAdapters.Repository.Generic.UuidData
