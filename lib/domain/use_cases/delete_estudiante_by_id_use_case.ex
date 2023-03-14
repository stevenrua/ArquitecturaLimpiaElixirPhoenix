defmodule MatricularCursoCa.Domain.UseCases.DeleteEstudianteByIdUseCase do
  alias MatricularCursoCa.Domain.Model.Estudiante
  require Logger
  @estudiante_behaviour Application.compile_env(:matricular_curso_ca, :estudiante_behaviour)
  ## TODO Add functions to business logic app
  def delete_student(data) do
    with {:ok, get_estudiante} <- delete_estudiante_by_id(Map.get(data, :id)) do
           Logger.info("Deleted estudiante: #{inspect(get_estudiante)}")
         {:ok, get_estudiante}
    end
  end

  def delete_estudiante_by_id(id) do
    @estudiante_behaviour.delete_by_id(id)
  end
end
