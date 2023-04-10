defmodule MatricularCursoCa.Infrastructure.Adapters.Repository.Repo.Migrations.CreateCursos do
  use Ecto.Migration

  def change do
    create table(:cursos, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :nombre_curso, :string
      add :descripcion, :string
      add :numero_estudiantes, :integer
      add :nota, :float
      #add :estudiante_id, references(:estudiantes, on_delete: :delete_all, type: :binary_id)
      timestamps()
    end

    #create index(:cursos, [:nombre_curso])
    create unique_index(:cursos, [:nombre_curso])
  end
end
