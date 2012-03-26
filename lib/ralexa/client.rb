require "addressable/uri"
require "net/http"

require "ralexa/uri_signer"

module Ralexa
  class Client

    def initialize(access_key_id, secret_access_key)
      @access_key_id = access_key_id
      @secret_access_key = secret_access_key
    end

    # Dependency injectors.
    attr_writer :net_http

    def get(host, path, query_values)
      uri = signed_uri(host, path, query_values)
      response = net_http.get_response(uri)
      response.error! unless response.is_a?(Net::HTTPSuccess)
      response.body
    end

    private

    def signed_uri(host, path, query_values)
      uri_signer.sign_uri(
        Addressable::URI.new(
          scheme: "http",
          host: host,
          path: path,
          query_values: query_values
        )
      )
    end

    def uri_signer
      UriSigner.new(@access_key_id, @secret_access_key)
    end

    ##
    # Injectable dependencies.

    def net_http
      @net_http || Net::HTTP
    end

  end
end
