defmodule Emay do
  use GenServer

  # GenServer APIs
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [name: __MODULE__])
  end

  # GenServer Callbacks
  def handle_call({:send_to, {phone, content} = _opts}, _from, _state) do
    {:reply, Emay.Query.to(phone, content), nil}
  end

  def handle_call(:query_balance, _from, _state) do
    {:reply, Emay.Query.query_balance, nil}
  end

  # APIs
  def send(phone, content) do
    GenServer.call(Emay, {:send_to, {phone, content}})
  end

  def query_balance do
    GenServer.call(Emay, :query_balance)
  end
end
