
module SmsManager
  module Epochta
    class Config < ::SmsManager::Core::Config
      attr_accessor :public_key, :private_key
    end
  end
end
