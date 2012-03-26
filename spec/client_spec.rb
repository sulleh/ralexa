require_relative "spec_helper"

require "ralexa/client"

module Ralexa
  describe Client do

    let(:client) do
      Client.new("id", "secret").tap do |c|
        c.net_http = net_http
      end
    end

    let(:net_http) { MiniTest::Mock.new }
    let(:response) { MiniTest::Mock.new }

    it "returns the response body of HTTP GET to a signed URI" do
      net_http.expect :get_response, response, [ %r{^http://example.org/test\?.*Signature=} ]
      response.expect :is_a?, true, [ Net::HTTPSuccess ]
      response.expect :body, "<xml/>"
      client.get("example.org", "/test", "a" => "b").must_equal "<xml/>"
    end

    it "raises an error if the HTTP request failed" do
      net_http.expect :get_response, response, [ %r{^http://example.org/test\?.*Signature=} ]
      response.expect :is_a?, false, [ Net::HTTPSuccess ]
      def response.error!; raise Net::HTTPError.new("", self); end
      ->{ client.get("example.org", "/test", "a" => "b") }.must_raise Net::HTTPError
    end

  end
end
