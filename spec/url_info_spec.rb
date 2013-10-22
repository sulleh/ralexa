require_relative "spec_helper"

module Ralexa
  describe UrlInfo do
    let(:url_info) { UrlInfo.new(client) }
    let(:client)   { MiniTest::Mock.new }

    describe "#rank" do
      def expected_params
        {
          "Action" => "UrlInfo",
          "ResponseGroup" => "Related,TrafficData,ContentData",
          "Url" => "flippa.com"
        }
      end

      before do
        client.expect :get, fixture("rank.xml"),
          ["awis.amazonaws.com", "/", expected_params]
      end

      it "fetches, parses, and returns the site's rank" do
        rank = url_info.rank("flippa.com")
        rank.must_equal 932
      end
   end

    describe "#info" do
      def expected_params
        {
          "Action"        => "UrlInfo",
          "ResponseGroup" => "Related,TrafficData,ContentData",
          "Url"           => "flippa.com"
        }
      end

      before do
        client.expect :get, fixture("rank.xml"),
          ["awis.amazonaws.com", "/", expected_params]
      end

      it "returns the alexa speed median load time in the result" do
        result = url_info.get("flippa.com")[:speed_median_load_time]
        result.must_equal 1930
      end

      it "returns the alexa speed load percentile in the result" do
        result = url_info.get("flippa.com")[:speed_load_percentile]
        result.must_equal 42
      end

      it "returns the alexa link count in the result" do
        result = url_info.get("flippa.com")[:link_count]
        result.must_equal 1788
      end

      it "returns the alexa ranking in the result" do
        result = url_info.get("flippa.com")[:ranking]
        result.must_equal 932
      end

      it "returns the alexa ranking delta in the result" do
        result = url_info.get("flippa.com")[:ranking_delta]
        result.must_equal -695
      end

      it "returns the alexa reach rank in the result" do
        result = url_info.get("flippa.com")[:reach_rank]
        result.must_equal 1230
      end

      it "returns the alexa reach rank delta in the result" do
        result = url_info.get("flippa.com")[:reach_rank_delta]
        result.must_equal -868
      end

      it "returns the alexa reach per million in the result" do
        result = url_info.get("flippa.com")[:reach_per_million]
        result.must_equal 1093
      end

      it "returns the alexa reach per million delta in the result" do
        result = url_info.get("flippa.com")[:reach_per_million_delta]
        result.must_equal 90
      end

      it "returns the alexa page views rank in the result" do
        result = url_info.get("flippa.com")[:page_views_rank]
        result.must_equal 579
      end

      it "returns the alexa page views rank delta in the result" do
        result = url_info.get("flippa.com")[:page_views_rank_delta]
        result.must_equal -406
      end

      it "returns the alexa page views per million in the result" do
        result = url_info.get("flippa.com")[:page_views_per_million]
        result.must_equal 98
      end

      it "returns the alexa page views per million delta in the result" do
        result = url_info.get("flippa.com")[:page_views_per_million_delta]
        result.must_equal 92
      end

      it "returns the alexa page views per user in the result" do
        result = url_info.get("flippa.com")[:page_views_per_user]
        result.must_equal 9
      end

      it "returns the alexa page views per user delta in the result" do
        result = url_info.get("flippa.com")[:page_views_per_user_delta]
        result.must_equal 1
      end

    end

  end
end
