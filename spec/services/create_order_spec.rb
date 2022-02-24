require 'rails_helper'

RSpec.describe CreateOrder, type: :service do
  describe 'CreateOrder.call' do
    let(:user) { create(:user, email: 'test@test.com', first_name: 'John', last_name: 'Dummy') }
    let(:order) { create(:order, user_id: user.id) }

    it 'creates order successfully' do
      test_order = CreateOrder.call(order, user)
      expect(test_order).to be_truthy
    end
  end
end
