defmodule MatricularCursoCa.Domain.UseCases.UsecaseEstudianteCurso.RegisterEstudianteCursoUseCase do
  alias MatricularCursoCa.Domain.Model.EstudiantesCursos
  require Logger

  @estudiante_curso_behaviour Application.compile_env(:matricular_curso_ca, :estudiante_curso_behaviour)
  @generate_uuid_behaviour Application.compile_env(:matricular_curso_ca, :generate_uuid_behaviour)

  ## TODO Add functions to business logic app
  @spec register(map()) :: {:error, atom()} | {:ok, EstudiantesCursos.t()}
  def register(data) do
    map_with_id = Map.put(data, :id, generate_uuid_estudiante_curso())

    with {:ok, estudiante_curso} <- EstudiantesCursos.new2(map_with_id[:id], map_with_id[:estudiante_data_id], map_with_id[:curso_data_id]),
          {:ok, new_estudiante_curso} <- register_estudiante_curso(estudiante_curso)  do
            Logger.info("New student_course: #{inspect(new_estudiante_curso)}")
         {:ok, new_estudiante_curso}

    end
  end

  defp register_estudiante_curso(estudiante_curso) do
    @estudiante_curso_behaviour.registervaina(estudiante_curso)
  end

  defp generate_uuid_estudiante_curso() do
    @generate_uuid_behaviour.generate_uuid()
  end
end
