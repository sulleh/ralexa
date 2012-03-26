require "nokogiri"

module Ralexa
  class LazyCollection

    include Enumerable

    def initialize(client, host, path, parameters, &parser)
      @client = client
      @host = host
      @path = path
      @parameters = parameters
      @parser = parser
    end

    def each
      parse(fetch(@parameters)).each do |item|
        yield item
      end
    end

    private

    def fetch(parameters)
      @client.get(@host, @path, parameters)
    end

    def parse(response_body)
      @parser.call(
        Nokogiri::XML.parse(response_body).remove_namespaces!
      )
    end

  end
end
