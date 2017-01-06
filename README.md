# Emay SMS client

## Installation and config

```elixir
# mix.exs
def application do
    [applications: [:emay]]
end

defp deps do
    [{:emay, "~> 0.1.0"}]
end
```
```elixir
# config/prod.secret.exs
config :emay, cdkey: "XXXX-XXXX-XXX-XXXX", password: "000000", signature: "【住艺】"
```
