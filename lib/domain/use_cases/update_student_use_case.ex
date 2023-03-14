defmodule MatricularCursoCa.Domain.UseCases.UpdateStudentUseCase do
  #alias MatricularCursoCa.Domain.Model.Estudiante
  require Logger
  @estudiante_behaviour Application.compile_env(:matricular_curso_ca, :estudiante_behaviour)
  ## TODO Add functions to business logic app
  def update_student(data) do
    with {:ok, get_estudiante} <- update_students(Map.get(data, :id), data)  do
           Logger.info("Update estudiante: #{inspect(get_estudiante)}")
         {:ok, get_estudiante}
    end
  end

  def update_students(id, data) do
    @estudiante_behaviour.update_student(id, data)
  end
end
