require_relative "spec_helper"

require "addressable/uri"
require "ralexa/uri_signer"

module Ralexa
  describe UriSigner do

    let(:time_utc) { Time.now.utc }
    let(:digest) { MiniTest::Mock.new }
    let(:hmac_signer) { MiniTest::Mock.new }
    let(:base64_encoder) { MiniTest::Mock.new }

    def signer
      UriSigner.new("id", "secret").tap do |rs|
        rs.digest = digest
        rs.hmac_signer = hmac_signer
        rs.base64_encoder = base64_encoder
        rs.time_utc = time_utc
      end
    end

    describe "for http://example.org/path?b=c&a=b" do

      let(:uri) { Addressable::URI.parse("http://example.org/path?b=c&a=b") }
      let(:signed_uri) { signer.sign_uri(uri) }
      let(:timestamp) { time_utc.strftime("%Y-%m-%dT%H:%M:%S.000Z") }

      before do
        ts = URI.escape(timestamp, /:/)
        combined = [
          "GET",
          "example.org",
          "/path",
          "AWSAccessKeyId=id&SignatureMethod=HmacFAKE&SignatureVersion=2&Timestamp=#{ts}&a=b&b=c"
        ].join("\n")
        hmac_signer.expect :digest, "the_hmac", [ digest, "secret", combined ]
        base64_encoder.expect :encode64, "base64_encoded\n", [ "the_hmac" ]
        digest.expect :name, "FAKE"
      end

      it "returns a signed URL" do
        signed_uri.host.must_equal "example.org"
        signed_uri.path.must_equal "/path"
        signed_uri.query_values.must_equal(
          "b" => "c",
          "a" => "b",
          "AWSAccessKeyId" => "id",
          "Signature" => "base64_encoded",
          "SignatureMethod" => "HmacFAKE",
          "SignatureVersion" => "2",
          "Timestamp" => timestamp,
        )
      end

      it "does not modify the passed uri" do
        signed_uri.wont_be_same_as uri
      end
    end

  end
end
