require "uri"

module Ralexa
  class CanonicalizedQueryString

    def initialize(parameters)
      @parameters = parameters
    end

    def to_s
      @parameters.sort.map do |k, v|
        "%s=%s" % [ escape_rfc3986(k), escape_rfc3986(v) ]
      end.join("&")
    end

    private

    def escape_rfc3986(string)
      URI.escape(string.to_s, /[^A-Za-z0-9\-_.~]/)
    end

  end
end
