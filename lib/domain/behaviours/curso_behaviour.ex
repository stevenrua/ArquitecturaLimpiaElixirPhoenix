defmodule MatricularCursoCa.Domain.Behaviours.CursoBehaviour do
  alias MatricularCursoCa.Domain.Model.Curso

  @callback register(Curso.t()) :: {:ok, Curso.t()} | {:error, reason::atom()}

  @callback find_all_cursos() :: {:ok, [Curso.t()]} | {:error, reason::atom()}

  @callback find_by_id2(String.t()) :: {:ok, Curso.t()} | {:error, reason::atom()}

  @callback update_curso(String.t(), Curso.t()) :: {:ok, Curso.t()} | {:error, reason::atom()}

  # @callback replace_function_name(param_one::term, param_two::term)::{:ok, true::term} | {:error, reason::term}
end
