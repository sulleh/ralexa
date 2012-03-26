module Ralexa
  class PaginatingCollection < LazyCollection

    def initialize(client, host, path, parameters, limit, per_page, &parser)
      validate_parameters(parameters)
      super(client, host, path, parameters, &parser)
      @limit = limit
      @per_page = per_page
    end

    def each
      Paginator.new(@per_page, @limit).pages.each do |page|
        parse(fetch(parameters(page))).each do |item|
          yield item
        end
      end
    end

    private

    def parameters(page)
      @parameters.merge("Start" => page.start, "Count" => page.count)
    end

    def validate_parameters(parameters)
      parameters.keys.each do |k|
        if %w{start count}.include?(k.to_s.downcase)
          raise Error,
            "Limit & Count must not be specified for PaginatingCollection"
        end
      end
    end

    Error = Class.new(StandardError)
  end
end
