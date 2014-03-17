module SmsManager
  module Epochta
    class ClientManager < BaseManager
      GET_BALANCE = 'getUserBalance'

      def update_balance!(client)
        client.balance = do_request({:currency => 'RUB'}, GET_BALANCE)['result']['balance_currency']
        client
      end
    end
  end
end
