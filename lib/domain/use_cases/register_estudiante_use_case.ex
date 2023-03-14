defmodule MatricularCursoCa.Domain.UseCases.RegisterEstudianteUseCase do

  @moduledoc """
  TODO Updates usecase description
  """
  alias MatricularCursoCa.Domain.Model.Estudiante
  require Logger

  @estudiante_behaviour Application.compile_env(:matricular_curso_ca, :estudiante_behaviour)
  @generate_uuid_behaviour Application.compile_env(:matricular_curso_ca, :generate_uuid_behaviour)

  ## TODO Add functions to business logic app
  @spec register(map()) :: {:error, atom()} | {:ok, Estudiante.t()}
  def register(data) do
    map_with_id = Map.put(data, :id, generate_uuid_estudiante())

    with {:ok, estudiante} <- Estudiante.new(map_with_id[:id], map_with_id[:nombres], map_with_id[:apellidos], map_with_id[:edad], map_with_id[:num_identi], map_with_id[:promedio]),
          {:ok, new_estudiante} <- register_estudiante(estudiante)  do
            Logger.info("New student: #{inspect(new_estudiante)}")
         {:ok, new_estudiante}

    end
  end

  defp register_estudiante(estudiante) do
    @estudiante_behaviour.register(estudiante)
  end

  defp generate_uuid_estudiante() do
    @generate_uuid_behaviour.generate_uuid()
  end

end
