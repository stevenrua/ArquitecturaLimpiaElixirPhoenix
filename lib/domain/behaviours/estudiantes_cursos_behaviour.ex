defmodule MatricularCursoCa.Domain.Behaviours.EstudiantesCursosBehaviour do
  alias MatricularCursoCa.Domain.Model.EstudiantesCursos

  IO.puts("que pasa ps con ud")
  @callback registervaina(EstudiantesCursos.t()) :: {:ok, EstudiantesCursos.t()} | {:error, reason::atom()}
  # @callback replace_function_name(param_one::term, param_two::term)::{:ok, true::term} | {:error, reason::term}
end
