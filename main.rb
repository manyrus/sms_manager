
require_relative 'lib/sms_manager'

sms_manager = SmsManager::Epochta::SmsManager.new
sms_manager.config = SmsManager::Epochta::Config.new do |conf|
  conf.public_key = 'c65628173b2953389963e2e6ed92610e'
  conf.private_key = 'baf85af2aa6c38a75777dc5b44b12332'
end

sms = SmsManager::Core::Sms.new
sms.from = '7'
sms.to = '79216778055'
sms.msg = 'hello!'

p sms_manager.update_cost!(sms).cost

