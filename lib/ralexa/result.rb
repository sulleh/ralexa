require "nokogiri"

module Ralexa
  class Result

    def initialize(client, host, path, parameters, &parser)
      @client = client
      @host = host
      @path = path
      @parameters = parameters
      @parser = parser
    end

    def result
      parse(fetch(@parameters))
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
