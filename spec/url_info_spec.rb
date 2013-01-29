require_relative "spec_helper"

module Ralexa
  describe UrlInfo do

    let(:url_info) { UrlInfo.new(client) }
    let(:client) { MiniTest::Mock.new }

    describe "#rank" do
      def expected_params
        {
          "Action" => "Rank",
          "ResponseGroup" => "Rank"
        }
      end
    end

  end
end
