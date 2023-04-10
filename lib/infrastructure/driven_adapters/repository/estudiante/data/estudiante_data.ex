defmodule MatricularCursoCa.Infrastructure.Adapters.Repository.Estudiante.Data.EstudianteData do
  alias MatricularCursoCa.Infrastructure.Adapters.Repository.Curso.Data.CursoData
  #alias MatricularCursoCa.Infrastructure.Adapters.Repository.EstudianteCurso.Data.EstudianteCursoData
  use Ecto.Schema
  import Ecto.Changeset

  ## TODO: Add schema definition
  # Types https://hexdocs.pm/ecto/Ecto.Schema.html#module-primitive-types

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "estudiantes" do
    field :apellidos, :string
    field :edad, :integer
    field :nombres, :string
    field :num_identi, :string
    field :promedio, :float
    #has_many :cursos, EstudianteCursoData, foreign_key: :curso_id -- intenta funcionar
    many_to_many :cursos, CursoData, join_through: "estudiantes_cursos"
    timestamps()
  end
  @doc false
  def changeset(estudiante, attrs) do
    IO.puts("Entra y valida")
    estudiante
    |> cast(attrs, [:id, :num_identi, :nombres, :apellidos, :edad, :promedio])
    |> validate_required([:num_identi, :nombres, :apellidos, :edad, :promedio])
    |> validate_length(:num_identi, min: 10, message: "número de identificación solo tiene 10 digitos")
    |> unique_constraint(:num_identi, message: "Estudiante ya existe en DB")
  end

end
