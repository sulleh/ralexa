module Ralexa
  class UrlInfo < AbstractService

    # Alexa data for an individual site
    def get(url, params = {})
      result({"ResponseGroup" => "Related,TrafficData,ContentData", "Url" => url}, params) do |doc|
        @document = doc

        {
          speed_median_load_time:       speed_median_load_time,
          speed_load_percentile:        speed_load_percentile,
          link_count:                   link_count,
          ranking:                      ranking,
          ranking_delta:                ranking_delta,
          reach_rank:                   reach_rank,
          reach_rank_delta:             reach_rank_delta,
          reach_per_million:            reach_per_million,
          reach_per_million_delta:      reach_per_million_delta,
          page_views_rank:              page_views_rank,
          page_views_rank_delta:        page_views_rank_delta,
          page_views_per_million:       page_views_per_million,
          page_views_per_million_delta: page_views_per_million_delta,
          page_views_per_user:          page_views_per_user,
          page_views_per_user_delta:    page_views_per_user_delta
        }
      end
    end

    # The site's Alexa rank (a legacy method)
    def rank(url, params = {})
      get(url, params)[:ranking]
    end

    private

    attr_accessor :document

    def host; "awis.api.alexa.com" end
    def path; "/api" end
    def default_params; {"Action" => "UrlInfo"}; end

    def speed_median_load_time
      document.at("//UrlInfoResult/Alexa/ContentData/Speed/MedianLoadTime") &&
        document.at("//UrlInfoResult/Alexa/ContentData/Speed/MedianLoadTime").text.to_i
    end

    def speed_load_percentile
      document.at("//UrlInfoResult/Alexa/ContentData/Speed/Percentile") &&
        document.at("//UrlInfoResult/Alexa/ContentData/Speed/Percentile").text.to_i
    end

    def link_count
      document.at("//UrlInfoResult/Alexa/ContentData/LinksInCount") &&
        document.at("//UrlInfoResult/Alexa/ContentData/LinksInCount").text.to_i
    end

    def ranking
      document.at("//UrlInfoResult/Alexa/TrafficData/Rank") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/Rank").text.to_i
    end

    def ranking_delta
      document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/Rank/Delta") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/Rank/Delta").text.to_i
    end

    def reach_rank
      document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/Reach/Rank/Value") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/Reach/Rank/Value").text.to_i
    end

    def reach_rank_delta
      document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/Reach/Rank/Delta") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/Reach/Rank/Delta").text.to_i
    end

    def reach_per_million
      document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/Reach/PerMillion/Value") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/Reach/PerMillion/Value").text.gsub(',','').to_i
    end

    def reach_per_million_delta
      document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/Reach/PerMillion/Delta") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/Reach/PerMillion/Delta").text.to_i
    end

    def page_views_rank
      document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/Rank/Value") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/Rank/Value").text.to_i
    end

    def page_views_rank_delta
      document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/Rank/Delta") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/Rank/Delta").text.to_i
    end

    def page_views_per_million
      document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/PerMillion/Value") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/PerMillion/Value").text.to_i
    end

    def page_views_per_million_delta
      document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/PerMillion/Delta") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/PerMillion/Delta").text.to_i
    end

    def page_views_per_user
      document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/PerUser/Value") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/PerUser/Value").text.to_i
    end

    def page_views_per_user_delta
      document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/PerUser/Delta") &&
        document.at("//UrlInfoResult/Alexa/TrafficData/UsageStatistics/UsageStatistic/PageViews/PerUser/Delta").text.to_i
    end
  end
end
