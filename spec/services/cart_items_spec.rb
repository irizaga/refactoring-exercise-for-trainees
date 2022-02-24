require 'rails_helper'

RSpec.describe CreateOrder, type: :service do
  describe 'CartItems.call' do
    context 'adding items to order' do
      let(:user) { create(:user, first_name: 'John', last_name: 'Smith', email: 'test@testing.com') }
      let(:order) { create(:order, user_id: user.id) }
      let(:cart) { create(:cart, user_id: user.id) }
      let(:sale) { create(:sale) }
      let(:item) { create(:cart_item, cart_id: cart.id, sale: sale, quantity: 1) }

      it 'gets right cart.id' do
        CartItems.call(cart.items, order)
        expect(cart.id).to eq(1)
      end

      it 'changes item quantity' do
        expect { CartItems.call(cart.items, order) }.to change(OrderLineItem, :count).by(item.quantity)
      end
    end
  end
end
