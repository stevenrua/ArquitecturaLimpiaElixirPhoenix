defmodule MatricularCursoCa.Domain.UseCases.UsecaseCursos.GetAllCursosUseCase do
  #alias MatricularCursoCa.Domain.Model.Curso
  require Logger
  @curso_behaviour Application.compile_env(:matricular_curso_ca, :curso_behaviour)
  ## TODO Add functions to business logic app
  def find_all_cursos() do
    with {:ok, get_cursos} <- find_all_cursoss() do
           Logger.info("Founded cursos: #{inspect(get_cursos)}")
         {:ok, get_cursos}
    end
  end

  def find_all_cursoss() do
    @curso_behaviour.find_all_cursos()
  end
end
