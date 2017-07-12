defmodule Emay.Query do
  require URI
  import SweetXml

  @url "http://hprpt2.eucp.b2m.cn:8080"
  @timeout 2000
  @cdkey  Application.get_env(:emay, :cdkey)
  @password  Application.get_env(:emay, :password)
  @signature Application.get_env(:emay, :signature)

  @doc """
  发送短信
  """
  @spec to(charlist, charlist) :: atom
  def to(phone, content) do
    case URI.merge(@url, "/sdkproxy/sendsms.action")
    |> to_string
    |> HTTPoison.post({:form,
                      [cdkey: @cdkey,
                       password: @password,
                       phone: phone,
                       message: "#{@signature} #{content}"]},
      timeout: @timeout) do

      {:ok, res} ->
        case res
             |> Map.get(:body)
             |> String.strip
             |> xpath(~x"//error/text()")
             |>List.to_integer do
          0 ->
            :ok
          error_code ->
            {:error, error_code}
        end
      _ -> :error
    end
  end

  @doc """
  查询余额
  """
  @spec query_balance() :: number
  def query_balance do
   {balance, _} = URI.merge(@url, "/sdkproxy/querybalance.action?cdkey=#{@cdkey}&password=#{@password}")
    |> to_string
    |> HTTPoison.get!
    |> Map.get(:body)
    |> String.strip
    |> xpath(~x"//message/text()") |> to_string
    |> Float.parse

    balance
  end
end
