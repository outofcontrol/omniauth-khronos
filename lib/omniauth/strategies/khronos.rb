require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Khronos < OmniAuth::Strategies::OAuth2

      DEFAULT_SCOPE = 'email'

      option :name, "Khronos"

      option :client_options, {
        :site => 'https://authserver.khronos.org',
        :authorize_url => "https://authserver.khronos.org/oauth/authorize",
        :token_url => '/oauth/access_token'
      }

      uid{ raw_info['id'] }

      def authorize_params
        super.tap do |params|
          %w[display scope auth_type].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end

          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      info do
        {
          :name => raw_info['name'],
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