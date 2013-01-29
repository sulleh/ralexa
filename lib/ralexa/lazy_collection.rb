require "nokogiri"

module Ralexa
  class LazyCollection < Result

    include Enumerable

    def initialize(client, host, path, parameters, &parser)
      super(client, host, path, parameters, &parser)
    end

    def each
      parse(fetch(@parameters)).each do |item|
        yield item
      end
    end

  end
end
