defmodule GCloudex.Datastore.Impl do
  defmacro __using__(:datastore) do
    quote do
      use GCloudex.Datastore.Request

      @project_id   GCloudex.get_project_id
      @run_query_ep "https://datastore.googleapis.com/v1beta3/projects/#{@project_id}:runQuery"

      #################
      ### Run Query ###
      #################

      @doc """
      List instances from the project.
      """
      @spec query(query :: map) :: HTTPResponse.t
      def query(query) do
        body = query |> Poison.encode!
        request :post, @run_query_ep, ["Content-Type": "application/json"], body
      end
    end
  end
end
