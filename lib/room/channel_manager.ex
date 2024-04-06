defmodule ChannelManager do
  import Supervisor.Spec
  use CSP

  @name_channel :single_channel

  @spec start() :: {:error, any(), :single_channel} | {:ok, any(), :single_channel}
  def start do
    children = [
      worker(Channel, [[name: @name_channel, buffer_size: 10]])
    ]

    {status, pid_supervisor} = Supervisor.start_link(children, strategy: :one_for_one)
    start_receptor_service()
    IO.puts("Processing Channel.get/1 method waiting message")
    RoomManager.start()
    {status, pid_supervisor, @name_channel}
  end

  defp start_receptor_service do
    spawn(fn ->
      unless Channel.closed?(@name_channel) do
        case Channel.get(@name_channel) do
          {:add_user, user} -> RoomManager.connect_participan(user)
          {:user_delete, user} -> RoomManager.disconnect_participan(user)
          {:write_message, user, message} -> RoomManager.add_message(user, message)
          _ -> {:error}
        end

        start_receptor_service()
      else
        IO.inspect("The channel is close the message will lost")
      end
    end)
  end
end
