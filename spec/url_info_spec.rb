require_relative "spec_helper"

module Ralexa
  describe UrlInfo do

    let(:url_info) { UrlInfo.new(client) }
    let(:client) { MiniTest::Mock.new }

    describe "#rank" do
      def expected_params
        {
          "Action" => "UrlInfo",
          "ResponseGroup" => "Rank",
          "Url" => "google.com"
        }
      end
      before do
        client.expect :get, fixture("rank.xml"),
          ["awis.amazonaws.com", "/", expected_params]
      end
      it "fetches, parses, and returns the site's rank" do
        rank = url_info.rank("google.com")
        rank.must_equal 1
      end 
    end

  end
end
