module Seekr
  class Report
    include Seekr::Client

    def initialize(monitor_id)
      @monitor_id = monitor_id
    end

    def general(filters={})
      fetch("/report", filters)
    end

    def by_cities(filters={})
      fetch("/report_cities", filters)
    end

    def by_tags(filters={})
      fetch("/report_tags", filters)
    end

    def by_states(filters={})
      fetch("/report_states", filters)
    end

    def by_words(filters={})
      fetch("/report_words", filters)
    end

    def by_people(filters={})
      fetch("/report_users", filters)
    end

    private
    def fetch(report, filters)
      filters.merge!({ search_id: @monitor_id })
      get(report, filters)
    end
  end
end
