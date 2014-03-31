module SmsManager
  class EpochtaFactory
    attr_reader :factory_config

    def initialize(public_key:, private_key:)
      @config = SmsManager::Epochta::Config.new do |conf|
        conf.public_key = public_key
        conf.private_key = private_key
      end
      @factory_config = {
          beauty:true,
          check:true
      }
    end

    def sms_manager
      manager = SmsManager::Epochta::SmsManager.new @config

      manager

      manager = SmsManager::Decorators::BeautySmsManager.new manager if @factory_config[:beauty]


    end
  end
end
