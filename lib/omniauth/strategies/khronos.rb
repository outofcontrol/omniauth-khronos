require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Khronos < OmniAuth::Strategies::OAuth2

      DEFAULT_SCOPE = 'email'

      option :name, "Khronos"

      option :client_options, {
        :site => 'https://authserve.khronos.org',
        :token_url => '/oauth/access_token'
      }

      option :access_token_options, {
        :header_format => 'OAuth %s',
        :param_name => 'access_token'
      }

      uid{ raw_info['email'] }

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

      def access_token_options
        options.access_token_options.inject({}) { |h,(k,v)| h[k.to_sym] = v; h }
      end

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

      protected

      def build_access_token
        super.tap do |token|
          token.options.merge!(access_token_options)
        end
      end

    end
  end
end
