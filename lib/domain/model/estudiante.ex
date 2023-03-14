defmodule MatricularCursoCa.Domain.Model.Estudiante do

  defstruct [
    :id,
    :nombres,
    :apellidos,
    :edad,
    :num_identi,
    :promedio
  ]

  @type t() :: %__MODULE__{
    id: binary(),
    nombres: String.t(),
    apellidos: String.t(),
    edad: number(),
    num_identi: String.t(),
    promedio: float()
  }

  def new(id, _, _, _, _, _) when (is_nil(id)), do: {:error, :invalid_estudiante}

  def new(id, nombres, apellidos, edad, num_identi, promedio) do
    {
      :ok,
      %__MODULE__{
                id: id,
                nombres: nombres,
                apellidos: apellidos,
                edad: edad,
                num_identi: num_identi,
                promedio: promedio
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
