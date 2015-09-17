module Seekr
  class Occurrence
    include Seekr::Client

    def initialize(monitor_id)
      @monitor_id = monitor_id
    end

    def all_paginated(options={})
      get("/search_results", params.merge(options))
    end

    private
    def params
      {
        search_id: @monitor_id,
        per_page: 100
      }
    end
  end
end
