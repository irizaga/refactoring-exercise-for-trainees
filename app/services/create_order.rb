# frozen_string_literal: true

# Order creation
class CreateOrder < ApplicationService
  def initialize(purchase_params, user)
    @purchase_params = purchase_params
    @user = user
  end

  def call
    create_order
  end

  private

  def create_order
    Order.create!(
      user: @user,
      first_name: @user.first_name,
      last_name: @user.last_name,
      address_1: @purchase_params[:address_1],
      address_2: @purchase_params[:address_2],
      city: @purchase_params[:city],
      state: @purchase_params[:state],
      country: @purchase_params[:country],
      zip: @purchase_params[:zip]
    )
  end
end
