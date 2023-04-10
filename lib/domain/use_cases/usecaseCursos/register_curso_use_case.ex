defmodule MatricularCursoCa.Domain.UseCases.UsecaseCursos.RegisterCursoUseCase do
  alias MatricularCursoCa.Domain.Model.Curso
  require Logger

  @curso_behaviour Application.compile_env(:matricular_curso_ca, :curso_behaviour)
  @generate_uuid_behaviour Application.compile_env(:matricular_curso_ca, :generate_uuid_behaviour)

  ## TODO Add functions to business logic app
  @spec register(map()) :: {:error, atom()} | {:ok, Curso.t()}
  def register(data) do
    map_with_id = Map.put(data, :id, generate_uuid_curso())

    with {:ok, curso} <- Curso.new(map_with_id[:id], map_with_id[:nombre_curso], map_with_id[:descripcion], map_with_id[:numero_estudiantes], map_with_id[:nota]),
          {:ok, new_curso} <- register_curso(curso)  do
            Logger.info("New course: #{inspect(new_curso)}")
         {:ok, new_curso}

    end
  end

  defp register_curso(curso) do
    @curso_behaviour.register(curso)
  end

  defp generate_uuid_curso() do
    @generate_uuid_behaviour.generate_uuid()
  end
end
