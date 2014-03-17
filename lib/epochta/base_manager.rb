require 'net/http'
require 'digest/md5'
require 'json'

module SmsManager
  module Epochta

    class BaseManager
      VERSION = '3.0'.freeze
      API_URL = 'http://atompark.com/api/sms/3.0/'.freeze

      attr_accessor :config

      def initialize(config = nil)
        @config = config
      end

      protected
      def do_request(params, action)

        params.merge!({version:VERSION,
                       action:action,
                       key:@config.public_key,
                       test:@config.is_test? ? 1 : 0})

        params[:sum] = generate_sum params

        begin
          ret = JSON.parse(Net::HTTP.post_form(URI.parse(API_URL+action), params).body)
        rescue JSON::ParserError, TypeError
          raise ::SmsManager::Errors::BadDataError.new
        end
        ret
      end

      private

      def generate_sum(params)
        Digest::MD5.hexdigest(params.keys.sort.map{|k| params[k]}.join('')+@config.private_key)
      end
    end
  end
end
