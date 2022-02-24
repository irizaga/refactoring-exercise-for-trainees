# frozen_string_literal: false

# Creates user
class CreateUser < ApplicationService
  def initialize(user, cart)
    @user = user
    @cart = cart
  end

  def call
    create_user
  end

  private

  def create_user
    return @cart.user unless @cart.user.nil?

    user_params = @user || {}
    User.create(**user_params.merge(guest: true))
  end
end
