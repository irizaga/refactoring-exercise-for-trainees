# frozen_string_literal: true

# Adds items to order
class CartItems < ApplicationService
  def initialize(items, order)
    @items = items
    @order = order
  end

  def call
    cart_items
  end

  private

  SHIPPING_COST = 100

  def cart_items
    @items.each do |item|
      item.quantity.times do
        @order.items << OrderLineItem.create(
          order: @order,
          sale: item.sale,
          unit_price_cents: item.sale.unit_price_cents,
          shipping_costs_cents: SHIPPING_COST,
          paid_price_cents: item.sale.unit_price_cents + SHIPPING_COST
        )
      end
    end
  end
end
