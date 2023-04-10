defmodule MatricularCursoCa.Infrastructure.Adapters.Rabbitmq.Rabbitmq do
  use AMQP
  alias MatricularCursoCa.Infrastructure.Adapters.Rabbitmq.Rabbitmq

  def start_link do
    AMQP.Connection.open()
  end

  def publish(message, queue) do
    with {:ok, connection} <- Rabbitmq.start_link(),
         {:ok, channel} <- Channel.open(connection),
         {:ok, _} <- Queue.declare(channel, queue) do
      Basic.publish(channel, "", queue, message)
      IO.puts "Mensaje enviado: #{message}"
      close(connection)
    end
  end

  def consume(queue) do
    with {:ok, connection} <- Rabbitmq.start_link(),
         {:ok, channel} <- Channel.open(connection),
         {:ok, _} <- Queue.declare(channel, queue),
         {:ok, _} <- Basic.consume(channel, queue, nil, no_ack: true) do

        IO.puts("Consumiendo mensajes encolados")
        close(connection)
        #receive_message(channel)
      # receive do
      #     {AMQP.Basic.Deliver, payload, _meta} ->
      #     IO.puts("Mensaje recibido: #{payload}")
      # end
    end
  end

  defp close(conn) do
    Connection.close(conn)
  end

end
