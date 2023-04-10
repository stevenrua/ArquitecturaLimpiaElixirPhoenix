defmodule MatricularCursoCa.Domain.UseCases.UsecaseCursos.UpdateCursoUseCase do
  require Logger
  @curso_behaviour Application.compile_env(:matricular_curso_ca, :curso_behaviour)
  ## TODO Add functions to business logic app
  def update_curso(data) do
    with {:ok, get_curso} <- update_cursos(Map.get(data, :id), data)  do
           Logger.info("Update curso: #{inspect(get_curso)}")
         {:ok, get_curso}
    end
  end

  def update_cursos(id, data) do
    @curso_behaviour.update_curso(id, data)
  end
end
