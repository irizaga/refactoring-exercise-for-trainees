require 'rails_helper'

RSpec.describe CreateUser, type: :service do
  describe 'CreateUser.call' do
    context 'if cart has user' do
      let!(:cart) { create(:cart) }

      it 'returns user from cart' do
        expect(CreateUser.call({}, cart)).to eq(cart.user)
      end
    end

    context 'if cart has no existing user' do
      let(:cart_with_no_user) { create(:cart, user: nil) }
      let(:user_for_testing) { create(:user) }
      let(:purchase_params) { {
        gateway: 'paypal',
        cart_id: cart_with_no_user.id,
        user: user_for_testing,
        address: {}
        } }

      it 'creates user from params' do
        target_user = purchase_params[:user]
        test_user = CreateUser.call(target_user, cart_with_no_user)
        expect(test_user.first_name).to eq(target_user.first_name)
      end
    end
  end
end
