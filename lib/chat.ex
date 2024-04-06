defmodule Chat do
  @moduledoc """
  This module is a kind of interface to use the Chat,
  behind it there is an agent that saves all the
  information about the room. Save messages, manage
  users (add or delete)
  """
  use CSP
  @type word() :: String.t()
  @name_channel :single_channel

  @doc """
  Start the room also the agent to keep the message and the last this create
  a supervisor to manage the Channel message
  """
  @spec start() :: {:error, pid(), :single_channel} | {:ok, word(), :single_channel}
  def start do
    ChannelManager.start()
  end

  @doc """
  Add a new user, if the user exist it will not save it again
  """
  @spec add_user(word()) :: :ok
  def add_user(user) do
    Channel.put(@name_channel, {:add_user, user})
  end

  @doc """
  Delete a user, but if the user was deleted or was not created then it does nothing
  """
  @spec user_delete(word()) :: :ok
  def user_delete(user) do
    Channel.put(@name_channel, {:user_delete, user})
  end

  @doc """
  This receives a user and a message to save the message, but if the user is not
   registered in the room, the message will not be saved.
  """
  @spec write_message(word(), word()) :: :ok
  def write_message(user, message) do
    Channel.put(@name_channel, {:write_message, user, message})
  end
end
