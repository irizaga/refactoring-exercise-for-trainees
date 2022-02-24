require 'rails_helper'

RSpec.describe GatewayList, type: :service do
  describe 'GatewayList.call' do
    context 'validates gateway' do
      it 'as true if it exists' do
        test_gateway = GatewayList.call('paypal')
        expect(test_gateway).to be_truthy
      end

      it 'as false if it is invalid' do
        test_gateway = GatewayList.call('dummy')
        expect(test_gateway).to be_falsey
      end
    end
  end
end
