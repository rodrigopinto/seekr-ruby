module Seekr
  class Monitor
    include Seekr::Client

    def all
      get("/searches")
    end

    def find(id)
      get("/search", search_id: id)
    end

    def tags(id)
      get("/tags", search_id: id)
    end
  end
end
