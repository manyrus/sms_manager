require 'webmock/rspec'
require File.dirname(__FILE__) + '/../spec_helper.rb'

class RequestHelper
  class << self
    def mock_request(addr, body, to_return)
      WebMock::API::stub_request(:post, 'http://atompark.com/api/sms/3.0/'+addr).
          with(:body => body,
               :headers => {'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type' => 'application/x-www-form-urlencoded', 'Host' => 'atompark.com', 'User-Agent' => 'Ruby'}).
          to_return(:status => 200, :body => to_return, :headers => {})
    end

    def mock_update_request(to_return)
      mock_request 'getUserBalance', {'action' => 'getUserBalance', 'currency' => 'RUB', 'key' => '123', 'sum' => '5fba07eec2f840e869e1033b7f514e41', 'test' => '0', 'version' => '3.0'}, to_return
    end

    def mock_send_request(ret)
      mock_request 'sendSMS', {'action' => 'sendSMS', 'key' => '123', 'phone' => '7921421423', 'sender' => '2233', 'sum' => 'c4c099c18f92c07fbc4c6ff734e44b51', 'test' => '0', 'text' => 'hello!', 'version' => '3.0'}, ret
    end

    def mock_update_cost_request(ret)
      mock_request 'checkCampaignPriceGroup', {'action' => 'checkCampaignPriceGroup',  'key' => '123', 'phones' => '[[7921421423]]',  'sum' => '55074e55a6039561fc486b72d25724df', 'test' => '0', 'text' => 'hello!', 'version' => '3.0','sender'=>'2233'}, ret
    end

  end
end

shared_examples 'manager bad request' do
  context 'when bad response json' do
    it 'should raise error' do
      mock_req '{"bad":json}'
      expect{ call }.to raise_error(SmsManager::Errors::BadDataError)
    end
  end

  context 'when response is nil' do
    it 'should raise error' do
      mock_req ''
      expect{ call }.to raise_error(SmsManager::Errors::BadDataError)
    end
  end
end