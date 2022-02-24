require 'rails_helper'

RSpec.describe CreateOrder, type: :service do
  describe 'CreateOrder.call' do
    context 'creates order correctly' do
      let(:user) { create(:user, first_name: 'John', last_name: 'Smith', email: 'test@testing.com') }
      let(:cart) { create(:cart) }
      let(:purchase_params) { { gateway: 'paypal', cart_id: cart.id, user: user, address: {} } }

      it 'given right params' do
        test_order = CreateOrder.call(purchase_params, user)
        expect(test_order.first_name).to eq(user.first_name)
      end
    end
  end
end
