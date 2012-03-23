require "base64"
require "digest/sha2"
require "openssl"

require "ralexa/canonicalized_query_string"

module Ralexa
  class UriSigner

    SIGNATURE_VERSION = 2

    def initialize(access_key_id, secret_access_key)
      @access_key_id = access_key_id
      @secret_access_key = secret_access_key
    end

    # dependency injectors
    attr_writer :digest
    attr_writer :hmac_signer
    attr_writer :base64_encoder
    attr_writer :time_utc

    def sign_uri(original_uri)
      original_uri.dup.tap do |uri|
        uri.query_values = uri.query_values.merge(
          "AWSAccessKeyId" => @access_key_id,
          "Timestamp" => timestamp,
          "SignatureVersion" => SIGNATURE_VERSION.to_s,
          "SignatureMethod" => signature_method,
        )
        uri.query_values = uri.query_values.merge(
          "Signature" => signature(uri)
        )
      end
    end

    private

    def string_to_sign(uri)
      [
        "GET",
        uri.host.downcase,
        uri.path,
        CanonicalizedQueryString.new(uri.query_values)
      ].join("\n")
    end

    def timestamp
      time_utc.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    end

    def signature_method
      "Hmac#{digest.name}"
    end

    def signature(uri)
      encode(hmac(string_to_sign(uri)))
    end

    def hmac(string_to_sign)
      hmac_signer.digest(digest, @secret_access_key, string_to_sign)
    end

    def encode(input)
      base64_encoder.encode64(input).chop
    end

    ##
    # Injectable dependencies.

    def digest
      @digest ||= OpenSSL::Digest::SHA256.new
    end

    def hmac_signer
      @hmac_signer || OpenSSL::HMAC
    end

    def base64_encoder
      @base64_encoder || Base64
    end

    def time_utc
      # don't store in ivar.
      @time_utc || Time.now.utc
    end

  end
end
