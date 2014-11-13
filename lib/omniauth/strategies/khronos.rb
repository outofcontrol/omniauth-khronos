require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Khronos < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "Khronos"

      option :client_options, {:site => "https://authserver.khronos.org", :authorize_url => "https://authserver.khronos.org/oauth/authorize"}

      uid{ raw_info['id'] }

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