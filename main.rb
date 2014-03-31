
require_relative 'lib/sms_manager'

factory = SmsManager::EpochtaFactory.new(
    public_key:'c65628173b2953389963e2e6ed92610e',
    private_key:'baf85af2aa6c38a75777dc5b44b12332'
)

p factory.sms_manager.get_cost(from:'79216778055', to:'79216778055', msg:'hello!')

