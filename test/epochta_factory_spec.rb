describe SmsManager::EpochtaFactory do
  subject{SmsManager::EpochtaFactory.new(public_key:'123', private_key:'456')}

  its(:factory_config){should equal {}}

  describe '#sms_manager' do
    let(:sms_manager){subject.sms_manager}

  end
end