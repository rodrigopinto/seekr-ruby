module Seekr
  class Occurrence
    include Seekr::Client

    def find_for(monitor_id, options = {})
      params = { search_id: monitor_id, per_page: 100 }.merge(options)
      get("/search_results", params)
    end
  end
end
