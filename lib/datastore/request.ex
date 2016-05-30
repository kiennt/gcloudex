defmodule GCloudex.Datastore.Request do
  alias HTTPoison, as: HTTP
  alias HTTPoison.HTTPResponse
  alias GCloudex.Auth, as: Auth

  @moduledoc """
  Offers HTTP requests to be used in by the Google Cloud SQL wrapper.
  """

  defmacro __using__(_opts) do
    quote do

      @doc """
      Sends a HTTP request with the given 'verb', 'headers' and 'body' to the
      specified 'endpoint'. The authorization and google project headers are
      added automatically.
      """
      @spec request(verb :: atom, endpoint :: binary, headers :: [{key :: binary, value :: binary}], body :: binary) :: HTTPResponse.t
      def request(verb, endpoint, headers \\ [], body \\ "") do
        HTTP.request(
          verb,
          endpoint,
          body,
          headers ++ [{"Authorization", "Bearer #{Auth.get_token_storage(:datastore)}"}],
          []
          )
      end

      defoverridable [
        request: 3,
        request: 4,
      ]
    end
  end
end
