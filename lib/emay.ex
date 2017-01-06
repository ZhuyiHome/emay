defmodule Emay do

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
  @spec to(string, string) :: atom
  def to(phone, content) do
    case URI.merge(@url, "/sdkproxy/sendsms.action")
    |> to_string
    |> HTTPoison.post({:form,
                      [cdkey: @cdkey,
                       password: @password,
                       phone: phone,
                       message: "#{@signature} #{content}"]},
      timeout: @timeout) do

      {:ok, _} -> :ok
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
