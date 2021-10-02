require "addressable/uri"
require "net/http"

module Ralexa
  class Client

    def initialize(api_key)
      @api_key = api_key
    end

    # Dependency injectors.
    attr_writer :net_http

    def get(host, path, query_values)
      uri = request_uri(host, path, query_values)
      response = request(uri, { 'x-api-key' => @api_key })
      response.error! unless response.is_a?(Net::HTTPSuccess)
      response.body
    end

    private

    def request_uri(host, path, query_values)
      Addressable::URI.new(
        scheme: "https",
        host: host,
        path: path,
        query_values: query_values
      )
    end

    def request(uri, headers)
      req = net_http::Get.new(uri)
      headers.each do |key, value|
        req[key] = value
      end
      net_http.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
    end

    ##
    # Injectable dependencies.

    def net_http
      @net_http || Net::HTTP
    end

  end
end
