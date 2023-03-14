defmodule MatricularCursoCa.Infrastructure.Adapters.Repository.Estudiante.Data.EstudianteData do
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
    # many_to_many :cursos, MatricularCurso.Cursos.Curso, join_through: "estudiantes_cursos"
    # belongs_to :colegio, MatricularCurso.Colegios.Colegio
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
