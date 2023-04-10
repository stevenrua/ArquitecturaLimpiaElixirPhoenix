defmodule MatricularCursoCa.Infrastructure.Adapters.Repository.Curso.CursoDataRepository do
  alias MatricularCursoCa.Infrastructure.Adapters.Repository.Repo
  alias MatricularCursoCa.Infrastructure.Adapters.Repository.Curso.Data.CursoData
  alias MatricularCursoCa.Domain.Model.Curso

  ## TODO: Update behaviour
  # @behaviour MatricularCursoCa.Domain.Behaviours.CursoBehaviour

  @behaviour MatricularCursoCa.Domain.Behaviours.CursoBehaviour


  def register(entity) do
    case to_data(entity) |> Repo.insert  do
      {:ok, entity} -> {:ok, entity |> to_entity()}
      error -> error
    end
  end

  def find_all_cursos() do
    {:ok, (CursoData |> Repo.all() |> Repo.preload(:estudiantes))}
  end

  def find_by_id2(id) do
    IO.puts("Entra a buscar curso")
    case (Repo.get!(CursoData, id) |> Repo.preload(:estudiantes)) do
      {:ok, entity} -> {:ok, entity |> to_entity()}
      error -> error
    end
    #{:ok, EstudianteData |> Repo.get!(id) |> to_entity}
  end

  def update_curso(id, entity) do
    curso = Repo.get!(CursoData, id)
    curso = Ecto.Changeset.change curso, nombre_curso: entity.nombre_curso,
    descripcion: entity.descripcion, numero_estudiantes: entity.numero_estudiantes, nota: entity.nota
      case Repo.update curso do
        {:ok, entity} -> {:ok, entity |> to_entity}
        error -> error
      end
  end

  defp to_entity(nil), do: nil
  defp to_entity(data) do
    struct(Curso, data |> Map.from_struct)
  end

  defp to_data(entity) do
    prop = CursoData.changeset(%CursoData{}, entity |> Map.from_struct).changes
    struct(CursoData, prop)
  end
end
