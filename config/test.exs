import Config

config :matricular_curso_ca, timezone: "America/Bogota"

config :matricular_curso_ca,
       http_port: 8083,
       enable_server: true,
       secret_name: "",
       region: "",
       version: "0.0.1",
       in_test: true,
       custom_metrics_prefix_name: "matricular_curso_ca_local"

config :logger,
       level: :debug
