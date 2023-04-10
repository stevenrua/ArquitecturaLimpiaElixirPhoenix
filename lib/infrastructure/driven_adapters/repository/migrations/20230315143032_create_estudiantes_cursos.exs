defmodule MatricularCursoCa.Infrastructure.Adapters.Repository.Repo.Migrations.CreateEstudiantesCursos do
  use Ecto.Migration

  def change do
    create table(:estudiantes_cursos, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :estudiante_data_id, references(:estudiantes, on_delete: :delete_all, type: :binary_id)
      add :curso_data_id, references(:cursos, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    # create index(:estudiantes_cursos, [:estudiante_id])
    # create index(:estudiantes_cursos, [:curso_id])
    create unique_index(:estudiantes_cursos, [:estudiante_data_id, :curso_data_id])
  end
end
