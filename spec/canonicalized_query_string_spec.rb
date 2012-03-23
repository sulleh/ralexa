# encoding: utf-8

require_relative "spec_helper"

require "ralexa/canonicalized_query_string"

module Ralexa
  describe CanonicalizedQueryString do

    def q(parameters)
      CanonicalizedQueryString.new(parameters).to_s
    end

    it "sorts parameters by key into a query string" do
      q("a" => "3", "c" => "2", "b" => "1").must_equal "a=3&b=1&c=2"
    end

    it "does not URL-encode RFC 3986 unreserved characters" do
      q("AZaz09-_.~" => "AZaz09-_.~").must_equal "AZaz09-_.~=AZaz09-_.~"
    end

    it "percent-encodes other characters" do
      q("=&/" => "✈").must_equal "%3D%26%2F=%E2%9C%88"
    end

    it "encodes space as '%20' not '+'" do
      q("a b" => "c d").must_equal "a%20b=c%20d"
    end

    it "handles empty parameters" do
      q("a" => "", "b" => nil).must_equal "a=&b="
    end

  end
end
