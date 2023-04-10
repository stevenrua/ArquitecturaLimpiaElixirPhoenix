defmodule MatricularCursoCa.Domain.UseCases.UsecaseCursos.GetCursoUseCase do
  alias MatricularCursoCa.Domain.Model.Curso
  require Logger
  @curso_behaviour Application.compile_env(:matricular_curso_ca, :curso_behaviour)
  ## TODO Add functions to business logic app
  def find_by_id4(data) do
    with {:ok, curso} <- Curso.find_by_id(data[:id]),
         {:ok, get_curso} <- find_by_id_curso(Map.get(curso, :id))  do
          IO.puts("que pasa ps mija")
          Logger.info("Founded curso: #{inspect(get_curso)}")
         {:ok, get_curso}
    end
  end

  def find_by_id_curso(id) do
    IO.puts("entra a esta parte: #{id}")
   @curso_behaviour.find_by_id2(id)
  end
end
