require 'rails_helper'

RSpec.describe CreateUser, type: :service do
  describe 'CreateUser.call' do
    let(:user) { create(:user, email: 'test@test.com', first_name: 'John', last_name: 'Dummy') }
    let(:cart) { create(:cart) }

    it 'creates user if cart.user.nil' do
      test_user = CreateUser.call(user, cart)
      expect(test_user.first_name).to eq('John')
    end
  end
end
