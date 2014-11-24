require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Khronos < OmniAuth::Strategies::OAuth2

      option :client_options, {
        :site => 'https://authserve.khronos.org',
        :authorize_url => 'https://authserve.khronos.org/oauth/authorize',
        :token_url => '/oauth/access_token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          :email => raw_info['email'],
          :name => raw_info['name'],
          :nickname => raw_info['username']
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        @raw_info ||= access_token.get("/v1/users?access_token=#{access_token.token}").parsed
      end

    end
  end
end
