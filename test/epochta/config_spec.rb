require File.dirname(__FILE__) + '/helper.rb'

describe SmsManager::Epochta::Config do
  subject {
    SmsManager::Epochta::Config.new do |conf|
      conf.public_key = '123'
      conf.private_key = '456'
    end
  }

  its(:is_test?) {should be_false }
end