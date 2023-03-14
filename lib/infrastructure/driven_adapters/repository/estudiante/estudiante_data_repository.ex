defmodule MatricularCursoCa.Infrastructure.Adapters.Repository.Estudiante.EstudianteDataRepository do
  alias MatricularCursoCa.Infrastructure.Adapters.Repository.Repo
  alias MatricularCursoCa.Infrastructure.Adapters.Repository.Estudiante.Data.EstudianteData
  alias MatricularCursoCa.Domain.Model.Estudiante

  ## TODO: Update behaviour
  # estamos diciendo que va a implementar el behavior EstudianteBehaviour
  @behaviour MatricularCursoCa.Domain.Behaviours.EstudianteBehaviour

  def register(entity) do
    case to_data(entity) |> Repo.insert do
      {:ok, entity} -> {:ok, entity |> to_entity()}
      error -> error
    end
  end

  def find_by_id(id) do
    case EstudianteData |> Repo.get!(id) do
      {:ok, entity} -> {:ok, entity |> to_entity()}
      error -> error
    end
    #{:ok, EstudianteData |> Repo.get!(id) |> to_entity}
  end

  def find_all_students() do
    {:ok, EstudianteData |> Repo.all()}
  end

  def delete_by_id(id) do
    estudiante = Repo.get!(EstudianteData, id)
    case Repo.delete estudiante do
      {:ok, entity} -> {:ok, entity |> to_entity}
      error -> error
    end
  end

  def update_student(id, entity) do
    estudiante = Repo.get!(EstudianteData, id)
    estudiante = Ecto.Changeset.change estudiante, nombres: entity.nombres, apellidos: entity.apellidos,
    promedio: entity.promedio, edad: entity.edad, num_identi: entity.num_identi
    case Repo.update estudiante do
      {:ok, entity} -> {:ok, entity |> to_entity}
      error -> error
end
  end

  defp to_entity(nil), do: nil
  defp to_entity(data) do
    struct(Estudiante, data |> Map.from_struct)
  end

  defp to_data(entity) do
    prop = EstudianteData.changeset(%EstudianteData{}, entity |> Map.from_struct).changes
    struct(EstudianteData, prop)
  end
end
