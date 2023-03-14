defmodule MatricularCursoCa.Domain.UseCases.GetAllStudentsUseCase do
  alias MatricularCursoCa.Domain.Model.Estudiante
  require Logger
  @estudiante_behaviour Application.compile_env(:matricular_curso_ca, :estudiante_behaviour)
  ## TODO Add functions to business logic app
  def find_all_students() do
    with {:ok, get_estudiantes} <- find_all_studentss() do
           Logger.info("Founded estudiantes: #{inspect(get_estudiantes)}")
         {:ok, get_estudiantes}
    end
  end

  def find_all_studentss() do
    @estudiante_behaviour.find_all_students()
  end
end
