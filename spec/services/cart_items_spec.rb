require 'rails_helper'

RSpec.describe CreateOrder, type: :service do
  describe 'CartItems.call' do
    let(:user) { create(:user, email: 'test@test.com', first_name: 'John', last_name: 'Dummy') }
    let(:order) { create(:order, user_id: user.id) }
    let(:cart) { create(:cart, user_id: user.id) }

    it 'retuns true if parameters are right' do
      test_cart = CartItems.call(cart.items, order)
      expect(test_cart).to be_truthy
    end
  end
end
