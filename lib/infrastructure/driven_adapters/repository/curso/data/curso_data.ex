defmodule MatricularCursoCa.Infrastructure.Adapters.Repository.Curso.Data.CursoData do
  alias MatricularCursoCa.Infrastructure.Adapters.Repository.Estudiante.Data.EstudianteData
  #alias MatricularCursoCa.Infrastructure.Adapters.Repository.EstudianteCurso.Data.EstudianteCursoData
  use Ecto.Schema
  import Ecto.Changeset

  ## TODO: Add schema definition
  # Types https://hexdocs.pm/ecto/Ecto.Schema.html#module-primitive-types

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cursos" do
    field :descripcion, :string
    field :nombre_curso, :string
    field :numero_estudiantes, :integer
    field :nota, :float
    #many_to_many :estudiantes, EstudianteData, join_through: "estudiantes_cursos", join_keys: :id
    #has_many :estudiantes, EstudianteCursoData, foreign_key: :estudiante_id
    #has_many :cursos, CursoData, foreign_key: :estudiante_id
    #many_to_many :estudiantes, EstudianteData , join_through: "estudiantes_cursos"
    many_to_many :estudiantes, EstudianteData, join_through: "estudiantes_cursos"
    timestamps()
  end

  @doc false
  def changeset(curso, attrs) do
    curso
    |> cast(attrs, [:nombre_curso, :descripcion, :numero_estudiantes, :nota])
    |> validate_required([:nombre_curso, :descripcion, :numero_estudiantes, :nota])
    |> validate_length(:nombre_curso, min: 10, message: "el nombre del curso debe tener minimo 10 caracteres")
    |> unique_constraint(:nombre_curso, message: "el curso ya existe en la BD")
  end
end
