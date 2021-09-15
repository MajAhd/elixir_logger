defmodule ElxLogger.Server do
  @moduledoc false
  use GenServer

  def start_link(arg \\ []) do
    GenServer.start_link(__MODULE__, arg, name: :elx_logger)
  end

  def get_msgs do
    GenServer.call(:elx_logger, :get_msgs)
  end

  def add_msg(msg) do
    GenServer.cast(:elx_logger, {:add_msg, msg})
  end

  def init(msg) do
    {:ok, msg}
  end

  def handle_call(:get_msgs, _from, msgs) do
    {:reply, msgs, msgs}
  end

  def handle_cast({:add_msg, msg}, msgs) do
    {:noreply, [msg | msgs]}
  end
end
