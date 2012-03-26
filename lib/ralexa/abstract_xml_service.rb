require "nokogiri"

module Ralexa
  class AbstractXmlService

    def initialize(client)
      @client = client
    end

    private

    # Returns the response as an XML document stripped of namespaces.
    def dispatch(*params)
      Nokogiri::XML.parse(
        @client.get(host, path, merged_params(*params))
      ).remove_namespaces!
    end

    # A hash of the provided params hashes merged into the default_params.
    def merged_params(*params)
      params.reduce(default_params) do |merged_params, params|
        merged_params.merge(params)
      end
    end

  end
end
