require "ralexa/lazy_collection"

module Ralexa
  class AbstractService

    def initialize(client)
      @client = client
    end

    private

    # A lazy collection which fetches records on demand.
    def collection(*params, &parser)
      LazyCollection.new(@client, host, path, merged_params(*params), &parser)
    end

    # A hash of the provided params hashes merged into the default_params.
    def merged_params(*params)
      params.reduce(default_params) do |merged, params|
        merged.merge(params)
      end
    end

  end
end
