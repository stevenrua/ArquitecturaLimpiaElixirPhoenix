defmodule MatricularCursoCa.Domain.Model.EstudiantesCursos do
  defstruct [
    :id,
    :estudiante_data_id,
    :curso_data_id
  ]

  @type t() :: %__MODULE__{
    id: binary(),
    estudiante_data_id: String.t(),
    curso_data_id: String.t(),
  }

  def new2(id, _, _) when (is_nil(id)), do: {:error, :invalid_estudiante_curso}
  def new2(id, estudiante_data_id, curso_data_id) do
    IO.puts("entra")
    {
      :ok,
      %__MODULE__{
                id: id,
                estudiante_data_id: estudiante_data_id,
                curso_data_id: curso_data_id
              }
    }
  end
end
