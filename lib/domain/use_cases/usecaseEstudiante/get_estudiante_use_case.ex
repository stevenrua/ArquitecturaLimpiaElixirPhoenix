defmodule MatricularCursoCa.Domain.UseCases.GetEstudianteUseCase do
  alias MatricularCursoCa.Domain.Model.Estudiante
  require Logger
  @estudiante_behaviour Application.compile_env(:matricular_curso_ca, :estudiante_behaviour)
  ## TODO Add functions to business logic app
  def find_by_id(data) do
    with {:ok, estudiante} <- Estudiante.find_by_id(data[:id]),
         {:ok, get_estudiante} <- find_by_id_estudiante(Map.get(estudiante, :id))  do
           Logger.info("Founded estudiante: #{inspect(get_estudiante)}")
         {:ok, get_estudiante}
    end
  end

  def find_by_id_estudiante(id) do
    @estudiante_behaviour.find_by_id(id)
  end
end
