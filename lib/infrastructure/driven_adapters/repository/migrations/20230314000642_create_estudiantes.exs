defmodule MatricularCursoCa.Infrastructure.Adapters.Repository.Repo.Migrations.CreateEstudiantes do
  use Ecto.Migration

  def change do
    create table(:estudiantes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :num_identi, :string
      add :nombres, :string
      add :apellidos, :string
      add :edad, :integer
      add :promedio, :float
      #add :colegio_id, references(:colegios, on_delete: :delete_all, type: :binary_id)
      timestamps()
    end

    create unique_index(:estudiantes, [:num_identi])
  end
end
