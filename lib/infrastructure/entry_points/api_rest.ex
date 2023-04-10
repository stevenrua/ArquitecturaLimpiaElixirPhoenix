defmodule MatricularCursoCa.Infrastructure.EntryPoint.ApiRest do

  @moduledoc """
  Access point to the rest exposed services
  """

  alias MatricularCursoCa.Domain.UseCases.UpdateStudentUseCase
  alias MatricularCursoCa.Infrastructure.EntryPoint.ErrorHandler
  alias MatricularCursoCa.Domain.UseCases.RegisterEstudianteUseCase
  alias MatricularCursoCa.Domain.UseCases.GetEstudianteUseCase
  alias MatricularCursoCa.Domain.UseCases.GetAllStudentsUseCase
  alias MatricularCursoCa.Domain.UseCases.DeleteEstudianteByIdUseCase
  alias MatricularCursoCa.Domain.UseCases.UsecaseCursos.RegisterCursoUseCase
  alias MatricularCursoCa.Domain.UseCases.UsecaseCursos.GetAllCursosUseCase
  alias MatricularCursoCa.Domain.UseCases.UsecaseCursos.GetCursoUseCase
  alias MatricularCursoCa.Domain.UseCases.UsecaseCursos.UpdateCursoUseCase
  alias MatricularCursoCa.Infrastructure.Adapters.Rabbitmq.Rabbitmq
  require Logger
  use Plug.Router
  use Timex

  plug(CORSPlug,
    methods: ["GET", "POST", "PUT", "DELETE"],
    origin: [~r/.*/],
    headers: ["Content-Type", "Accept", "User-Agent"]
  )

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison)
  plug(Plug.Telemetry, event_prefix: [:matricular_curso_ca, :plug])
  plug(:dispatch)

  forward(
    "/matricular_curso_ca/api/health",
    to: PlugCheckup,
    init_opts: PlugCheckup.Options.new(json_encoder: Jason, checks: MatricularCursoCa.Infrastructure.EntryPoint.HealthCheck.checks)
  )


  get "/matricular_curso_ca/api/hello/" do
    build_response("Hello World", conn)
  end

  defp rabbitMQ(entity, event) do
    entity = Map.put(entity, :evento, event)
    Rabbitmq.publish(inspect(entity, pretty: true), "cola_steven")
  end

  #metodos http para estudiantes

  get "/matricular_curso_ca/api/estudiante/" do
    case GetAllStudentsUseCase.find_all_students() do
      {:ok, estudiantes} -> estudiantes = estudiantes |> Enum.map(fn elemento ->
        Map.drop(elemento, [:__meta__, :updated_at, :inserted_at])end)
        #Rabbitmq.consume("cola_steven")
        estudiantes |> build_response(conn)
      {:error, error} -> %{status: 500, body: error}
    end
  end

  get "/matricular_curso_ca/api/estudiante/:id" do
    estudiante = GetEstudianteUseCase.find_by_id(%{id: id})
    estudiante = Map.drop(estudiante, [:__meta__, :updated_at, :inserted_at])
    rabbitMQ(estudiante, "Estudiante consultado")
    build_response(estudiante, conn)
  end

  post "/matricular_curso_ca/api/estudiante" do
    # Convertimos el mapa con formato de String al formato de átomos
    params_map = conn.params |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)
    # Llamamos a nuestro caso de uso, le pasamos nuestro mapa convertido y hacemos las validaciones con pattern matching

    case RegisterEstudianteUseCase.register(params_map) do
      {:ok, estudiante} ->
        rabbitMQ(estudiante, "Estudiante registrado")
        estudiante |> build_response(conn)
      {:error, error} -> %{status: 500, body: error}
    end
  end

  put "/matricular_curso_ca/api/estudiante/:id" do
    # Convertimos el mapa con formato de String al formato de átomos
    params_map = conn.params |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)
    # Llamamos a nuestro caso de uso, le pasamos nuestro mapa convertido y hacemos las validaciones con pattern matching
    params_map = %{params_map | id: id}
    case UpdateStudentUseCase.update_student(params_map) do
      {:ok, estudiante} ->
        rabbitMQ(estudiante, "Estudiante actualizado")
        estudiante |> build_response(conn)
      {:error, error} -> %{status: 500, body: error}
    end
  end

  delete "/matricular_curso_ca/api/estudiante/:id" do
    case DeleteEstudianteByIdUseCase.delete_student(%{id: id}) do
      {:ok, estudiante} ->
        rabbitMQ(estudiante, "Estudiante eliminado")
        estudiante |> build_response(conn)
      {:error, error} -> %{status: 500, body: error}
    end
  end

  # metodos http para cursos

  get "/matricular_curso_ca/api/cursos/" do
    case GetAllCursosUseCase.find_all_cursos() do
      {:ok, cursos} -> cursos = cursos |> Enum.map(fn elemento ->
        Map.drop(elemento, [:__meta__, :updated_at, :inserted_at])end)
        #Rabbitmq.consume("cola_steven")
        cursos |> build_response(conn)
      {:error, error} -> %{status: 500, body: error}
    end
  end

  get "/matricular_curso_ca/api/cursos/:id" do
    curso = GetCursoUseCase.find_by_id4(%{id: id})
    curso = Map.drop(curso, [:__meta__, :updated_at])
    rabbitMQ(curso, "Curso consultado")
    build_response(curso, conn)
  end

  post "/matricular_curso_ca/api/cursos" do
    # Convertimos el mapa con formato de String al formato de átomos
    params_map = conn.params |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)
    # Llamamos a nuestro caso de uso, le pasamos nuestro mapa convertido y hacemos las validaciones con pattern matching

    case RegisterCursoUseCase.register(params_map) do
      {:ok, curso} ->
        rabbitMQ(curso, "curso registrado")
        curso |> build_response(conn)
      {:error, error} -> %{status: 500, body: error}
    end
  end

  put "/matricular_curso_ca/api/cursos/:id" do
    # Convertimos el mapa con formato de String al formato de átomos
    params_map = conn.params |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)
    # Llamamos a nuestro caso de uso, le pasamos nuestro mapa convertido y hacemos las validaciones con pattern matching
    params_map = %{params_map | id: id}
    case UpdateCursoUseCase.update_curso(params_map) do
      {:ok, curso} ->
        rabbitMQ(curso, "curso actualizado")
        curso |> build_response(conn)
      {:error, error} -> %{status: 500, body: error}
    end
  end

  def build_response(%{status: status, body: body}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(body))
  end

  def build_response(response, conn), do: build_response(%{status: 200, body: response}, conn)

  match _ do
    conn
    |> handle_not_found(Logger.level())
  end

  defp handle_error(error, conn) do
    error
    |> ErrorHandler.build_error_response()
    |> build_response(conn)
  end

  defp handle_bad_request(error, conn) do
    error
    |> ErrorHandler.build_error_response()
    |> build_bad_request_response(conn)
  end

  defp build_bad_request_response(response, conn) do
    build_response(%{status: 400, body: response}, conn)
  end

  defp handle_not_found(conn, :debug) do
    %{request_path: path} = conn
    body = Poison.encode!(%{status: 404, path: path})
    send_resp(conn, 404, body)
  end

  defp handle_not_found(conn, _level) do
    send_resp(conn, 404, "")
  end
end
