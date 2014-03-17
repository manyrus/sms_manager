require File.dirname(__FILE__) + '/helper.rb'

describe SmsManager::Epochta::ClientManager do

  subject {SmsManager::Epochta::ClientManager.new}

  before (:each) {
    subject.config = SmsManager::Epochta::Config.new do|conf|
      conf.public_key = '123'
      conf.private_key = '456'
    end
  }

  let(:client) {
    SmsManager::Core::Client.new
  }

  describe '#update_balance!' do

    let(:update_balance!) {subject.update_balance! client}

    it_behaves_like 'manager bad request'  do
      def mock_req(to_return)
        RequestHelper.mock_update_request to_return
      end

      let(:call) {update_balance!}
    end

    it 'should return client with updated balance'do
      RequestHelper.mock_update_request '{"result":{"balance_currency":123.45,"currency":"RUB"}}'
      update_balance!.balance.should == 123.45
    end
  end
end
