defmodule MatricularCursoCa.Infrastructure.DrivenAdapters.Repository.Generic.UuidData do
  alias MatricularCursoCa.Utils.IdGenerator
  @behaviour MatricularCursoCa.Domain.Behaviours.Generic.GenericBehaviour
  def generate_uuid() do
    IdGenerator.generate_uuid()
  end
end
