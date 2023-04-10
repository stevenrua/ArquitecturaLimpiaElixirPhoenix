defmodule MatricularCursoCa.Infrastructure.Adapters.Repository.EstudianteCurso.EstudianteCursoDataRepository do
  alias MatricularCursoCa.Infrastructure.Adapters.Repository.Repo
  alias MatricularCursoCa.Infrastructure.Adapters.Repository.EstudianteCurso.Data.EstudianteCursoData
  alias MatricularCursoCa.Domain.Model.EstudianteCurso


  ## TODO: Update behaviour
  @behaviour MatricularCursoCa.Domain.Behaviours.EstudiantesCursosBehaviour

  def find_by_id(id), do: EstudianteCursoData |> Repo.get(id) |> to_entity

  def registervaina(entity) do
    IO.puts("entra a registrar ")
    case to_data(entity) |> Repo.insert do
      {:ok, entity} -> {:ok, entity |> to_entity}
      error -> error
    end
  end


  defp to_entity(nil), do: nil
  defp to_entity(data) do
    ## TODO: Update Entity
    IO.puts("Entra to_entity")
    IO.inspect(data)
    struct(EstudianteCurso, data |> Map.from_struct)
  end

  defp to_data(entity) do
    IO.puts("Entra to_data")
    prop = EstudianteCursoData.changeset(%EstudianteCursoData{}, entity |> Map.from_struct).changes
    struct(EstudianteCursoData, prop)
  end


end
