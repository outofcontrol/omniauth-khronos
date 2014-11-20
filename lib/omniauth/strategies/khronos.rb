require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Khronos < OmniAuth::Strategies::OAuth2

      DEFAULT_SCOPE = 'email'

      option :name, "Khronos"

      option :client_options, {
        :site => 'https://authserve.khronos.org',
        :authorize_url => "/oauth/authorize",
        :token_url => '/oauth/access_token'
      }

      uid{ raw_info['id'] }

      def authorize_params
        super.tap do |params|
          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      info do
        {
          :username => raw_info['username'],
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/me').parsed
      end
    end
  end
end
