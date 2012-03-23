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

    it "returns the response body of HTTP GET to a signed URI" do
      net_http.expect :get, "<xml/>", [ %r{^http://example.org/test\?.*Signature=} ]
      client.get("example.org", "/test", "a" => "b").must_equal "<xml/>"
    end

  end
end
