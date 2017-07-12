defmodule Emay.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Emay, [])
    ]

    opts = [strategy: :one_for_one, name: Emay.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
