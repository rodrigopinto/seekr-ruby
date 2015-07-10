require 'sinatra/base'

class FakeSeekrMonitor < Sinatra::Base

  get '/api/search_results.json' do
    content = if params[:tag].present? && params[:tag] == [1]
      'occurrences_filter_by_tag.json'
    else
      'occurrences.json'
    end

    json_response 200, content
  end

  get '/api/search.json' do
    json_response 200, 'search.json'
  end

  get '/api/searches.json' do
    json_response 200, 'searches.json'
  end

  get '/api/tags.json' do
    json_response 200, 'tags.json'
  end

  get '/api/report.json' do
    content = if params[:date_from].present?
      'report_filtered_by_date_from.json'
    else
      'report_general.json'
    end

    json_response 200, content
  end

  get '/api/report_cities.json' do
    json_response 200, 'report_cities.json'
  end

  get '/api/report_tags.json' do
    content = if params[:tag].present?
      'report_tags_filtered_by_tag.json'
    else
      'report_tags.json'
    end
    json_response 200, content
  end

  get '/api/report_states.json' do
    content = if params[:date_from].present?
      'report_states_filtered_by_date.json'
    else
      'report_states.json'
    end
    json_response 200, content
  end

  get '/api/report_words.json' do
    content = if params[:date_from].present?
      'report_words_filtered_by_date.json'
    else
      'report_words.json'
    end
    json_response 200, content
  end

  get '/api/report_users.json' do
    content = if params[:date_from].present?
      'report_users_filtered_by_date.json'
    else
      'report_users.json'
    end
    json_response 200, content
  end

  before "/api/*" do
    authenticate!
  end

  private
    def json_response(response_code, file_name)
      content_type :json
      status response_code
      File.open(File.dirname(__FILE__) + '/../fixtures/' + file_name, 'rb').read
    end

    def authenticate!
      if authenticated?
        pass
      else
        json_response(403, "forbidden.json")
        halt 403
      end
    end

    def authenticated?
      params[:ts].present? && params[:key].present? && params[:hash].present?
    end
end
