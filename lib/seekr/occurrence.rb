require 'pry'
module Seekr
  class Occurrence
    include Seekr::Client

    PER_PAGE = 100

    def initialize(monitor_id)
      @monitor_id = monitor_id
    end

    def all_paginated(options={})
      options[:page] = 1
      response = get_search_results_json(options)
      iterate = !(response['search_results'].size < PER_PAGE)
      while iterate do
        options[:page] += 1
        next_page_response = get_search_results_json(options)['search_results']
        break if next_page_response.size.zero?
        response['search_results'].concat(next_page_response)
        iterate = !(next_page_response.empty? || next_page_response.size < PER_PAGE)
      end
      JSON.dump(response)
    end

    private
    def params
      {
        search_id: @monitor_id,
        per_page: PER_PAGE
      }
    end

    def get_search_results_json(options={})
      JSON.parse(get("/search_results", params.merge(options)))
    end
  end
end
