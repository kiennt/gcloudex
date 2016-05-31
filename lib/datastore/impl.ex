defmodule GCloudex.Datastore.Impl do
  defmacro __using__(:datastore) do
    quote do
      use GCloudex.Datastore.Request

      @project_id   GCloudex.get_project_id
      @base_endpoint "https://datastore.googleapis.com/v1beta3/projects/#{@project_id}:"

      @spec allocate_ids(query :: map) :: HTTPResponse.t
      def allocate_ids(query) do
        make_request("allocateIds", query)
      end

      @spec begin_transaction(query :: map) :: HTTPResponse.t
      def begin_transaction(query) do
        make_request("beginTransaction", query)
      end

      @spec commit(query :: map) :: HTTPResponse.t
      def commit(query) do
        make_request("commit", query)
      end

      @spec query(query :: map) :: HTTPResponse.t
      def query(query) do
        make_request("runQuery", query)
      end

      @spec rollback(query :: map) :: HTTPResponse.t
      def rollback(query) do
        make_request("rollback", query)
      end

      @spec lookup(query :: map) :: HTTPResponse.t
      def lookup(query) do
        make_request("lookup", query)
      end

      defp make_request(endpoint, query) do
        body = query |> Poison.encode!
        url = @base_endpoint <> endpoint
        request :post, url, ["Content-Type": "application/json"], body
      end
    end
  end
end
