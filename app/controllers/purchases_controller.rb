class PurchasesController < ApplicationController
  def create
    unless GatewayList.call(purchase_params[:gateway])
      return render json: { errors: [{ message: 'Gateway not supported!' }] }, status: :unprocessable_entity
    end

    cart_id = purchase_params[:cart_id]
    cart = Cart.find_by(id: cart_id)

    unless cart
      return render json: { errors: [{ message: 'Cart not found!' }] },
                    status: :unprocessable_entity
    end

    user = CreateUser.call(purchase_params[:user], cart)

    unless user.valid?
      return render json: { errors: user.errors.map(&:full_message).map { |message| { message: message } } },
                    status: :unprocessable_entity
    end

    order = CreateOrder.call(address_params, user)
    CartItems.call(cart.items, order)
    order.save

    unless order.valid?
      return render json: { errors: order.errors.map(&:full_message).map { |message| { message: message } } },
                    status: :unprocessable_entity
    end

    return render json: { status: :success, order: { id: order.id } }, status: :ok
  end

  private

  def purchase_params
    params.permit(
      :gateway,
      :cart_id,
      user: %i[email first_name last_name],
      address: %i[address_1 address_2 city state country zip]
    )
  end

  def address_params
    purchase_params[:address] || {}
  end
end
