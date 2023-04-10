defmodule MatricularCursoCa.Domain.Model.Curso do

  @moduledoc """
  TODO Updates module description
  """

  defstruct [
    :id,
    :nombre_curso,
    :descripcion,
    :numero_estudiantes,
    :nota
  ]

  @type t() :: %__MODULE__{
    id: binary(),
    nombre_curso: String.t(),
    descripcion: String.t(),
    numero_estudiantes: number(),
    nota: float()
  }

  def new(id, _, _, _, _) when (is_nil(id)), do: {:error, :invalid_curso}

  def new(id, nombre_curso, descripcion, numero_estudiantes, nota) do
    {
      :ok,
      %__MODULE__{
                id: id,
                nombre_curso: nombre_curso,
                descripcion: descripcion,
                numero_estudiantes: numero_estudiantes,
                nota: nota
              }
  }
  end

  def find_by_id(id) do
    {
      :ok,
      %__MODULE__{id: id}
    }
  end

end
