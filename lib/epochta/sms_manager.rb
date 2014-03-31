
module SmsManager
  module Epochta
    class SmsManager < BaseManager
      SEND_SMS = 'sendSMS'.freeze
      UPDATE_COST = 'checkCampaignPriceGroup'.freeze

      def send_sms!(sms)
        result = do_request({sender:sms.from, text:sms.msg, phone:sms.to},SEND_SMS)

        case result['code']
          when '304', '305', '103'
            raise ::SmsManager::Errors::LowBalanceError
          else
            raise ::SmsManager::Errors::UnknownError
        end if result.has_key? 'error'

        sms.sms_id = result['result']['id']
        sms
      end

      def update_cost!(sms)

        result = do_request({phones:"[[#{sms.to}]]", text:sms.msg, sender:sms.from}, UPDATE_COST)

        raise ::SmsManager::Errors::UnknownError if result.has_key? 'error'

        sms.cost = result['result']['price']
        sms
      end

      def get_cost(sms)
        update_cost!(sms).cost
      end
    end
  end
end
