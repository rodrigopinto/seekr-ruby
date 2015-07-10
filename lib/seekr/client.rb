require 'rest-client'

module Seekr
  module Client

    BASE_URL = "http://monitoramento.seekr.com.br/api"

    def get(method, params={})
      url = build_url(method, params)
      _get(url)
    end

    private
      def _get(url)
        RestClient.get url do |response, request, result, &block|
          case response.code
          when 200
            response
          when 403
            raise Seekr::HTTPForbidden
          end
        end
      end

      def build_url(method, params={})
        query_params = default_params.merge(params).to_param
        "#{BASE_URL}#{method}.json?#{query_params}"
      end

      def default_params
        timestamp = Time.zone.now.to_i
        hash = Digest::SHA1.hexdigest("#{Seekr.api_secret}#{timestamp}")
        {
          key: Seekr.api_key,
          ts: timestamp,
          hash: hash
        }
      end
  end
end
