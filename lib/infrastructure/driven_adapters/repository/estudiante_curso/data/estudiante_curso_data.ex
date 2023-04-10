defmodule MatricularCursoCa.Infrastructure.Adapters.Repository.EstudianteCurso.Data.EstudianteCursoData do
  alias MatricularCursoCa.Infrastructure.Adapters.Repository.Curso.Data.CursoData
  alias MatricularCursoCa.Infrastructure.Adapters.Repository.Estudiante.Data.EstudianteData
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "estudiantes_cursos" do

    belongs_to :estudiantes, EstudianteData, foreign_key: :estudiante_data_id
    belongs_to :cursos, CursoData, foreign_key: :curso_data_id

    timestamps()
  end

  @doc false
  def changeset(estudiante__curso, attrs) do

    estudiante__curso
    |> cast(attrs, [:estudiante_data_id, :curso_data_id])
    |> validate_required([])
  end
end
