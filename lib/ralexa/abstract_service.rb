module Ralexa
  class AbstractService

    def initialize(client)
      @client = client
    end

    private

    # a single result value
    def result(*params, &parser)
      collection(*params, &parser).first
    end

    # A lazy collection which fetches records on demand.
    def collection(*params, &parser)
      LazyCollection.new(
        @client,
        host,
        path,
        merged_params(*params),
        &parser
      )
    end

    def paginating_collection(limit, per_page, *params, &parser)
      PaginatingCollection.new(
        @client,
        host,
        path,
        merged_params(*params),
        limit,
        per_page,
        &parser
      )
    end

    # A hash of the provided params hashes merged into the default_params.
    def merged_params(*params)
      params.reduce(default_params) do |merged, params|
        merged.merge(params)
      end
    end

  end
end
