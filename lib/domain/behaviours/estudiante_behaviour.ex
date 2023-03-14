defmodule MatricularCursoCa.Domain.Behaviours.EstudianteBehaviour do
  alias MatricularCursoCa.Domain.Model.Estudiante

  @callback register(Estudiante.t()) :: {:ok, Estudiante.t()} | {:error, reason::atom()}

  @callback find_by_id(String.t()) :: {:ok, Estudiante.t()} | {:error, reason::atom()}

  @callback find_all_students() :: {:ok, [Estudiante.t()]} | {:error, reason::atom()}

  @callback delete_by_id(String.t()) :: {:ok, Estudiante.t()} | {:error, reason::atom()}

  @callback update_student(String.t(), Estudiante.t()) :: {:ok, Estudiante.t()} | {:error, reason::atom()}
end
