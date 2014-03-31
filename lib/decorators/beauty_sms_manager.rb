module SmsManager
  module Decorators
    class BeautySmsManager


      def initialize(sms_manager)
        @sms_manager = sms_manager
      end

      def send_sms!(*args)
        @sms_manager.send_sms! create_sms(args)
      end

      def get_cost(*args)
        @sms_manager.get_cost create_sms(args)
      end

      def update_cost!(*args)
        @sms_manager.update_cost! create_sms args
      end
      private
      def create_sms(args)
        if args[0].kind_of? SmsManager::Core::Sms
          args[0]
        elsif args[0].count == 3
          sms = SmsManager::Core::Sms.new
          sms.from = args[0][:from]
          sms.to = args[0][:to]
          sms.msg = args[0][:msg]
          sms
        else
          raise RuntimeError.new 'unknown args'
        end
      end

    end
  end
end