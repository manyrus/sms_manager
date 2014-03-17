require File.dirname(__FILE__) + '/helper.rb'


describe SmsManager::Epochta::SmsManager do
  subject{SmsManager::Epochta::SmsManager.new}

  before (:each) {
    subject.config = SmsManager::Epochta::Config.new do|conf|
      conf.public_key = '123'
      conf.private_key = '456'
    end
  }

  let :sms do
    sms = SmsManager::Core::Sms.new
    sms.from = '2233'
    sms.to = '7921421423'
    sms.msg = 'hello!'
    sms
  end

  describe '#send!' do
    let(:send_sms!) { subject.send_sms!(sms)}

    it_behaves_like 'manager bad request' do
      def mock_req(to_return)
        RequestHelper.mock_send_request to_return
      end

      let(:call) {send_sms!}
    end



    it 'should do request and return sms' do
      RequestHelper.mock_send_request '{"result":{"id":"22-21"}}'
      send_sms!.sms_id.should == '22-21'
    end


    %w(304 305 103).each do |error|
      it "should raise low balance on #{error} code from request" do
        RequestHelper.mock_send_request '{"error":"error", "code":"'+error+'", "result":"false"}'
        expect{ send_sms! }.to raise_error(SmsManager::Errors::LowBalanceError)
      end
    end

    it 'should raise unknown error' do
      RequestHelper.mock_send_request '{"error":"error", "code":"-1", "result":"false"}'
      expect{ send_sms! }.to raise_error(SmsManager::Errors::UnknownError)
    end
  end

  describe '#update_status!'

  describe '#update_cost!' do
    let (:update_cost!){subject.update_cost!(sms)}

    it_behaves_like 'manager bad request' do
      def mock_req(to_return)
        RequestHelper.mock_update_cost_request to_return
      end

      let(:call) {update_cost!}
    end

    it 'should do request and set balance for sms' do
      RequestHelper.mock_update_cost_request '{"result":{"price":123.45}}'
      update_cost!.cost.should == 123.45
    end
  end
end