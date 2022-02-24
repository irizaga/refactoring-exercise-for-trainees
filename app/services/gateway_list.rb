# frozen_string_literal: true

# Validating available gateways
class GatewayList < ApplicationService
  GATEWAYS = %w[paypal stripe].freeze

  def initialize(gateway)
    @gateway = gateway
  end

  def call
    validate_gateway
  end

  private

  def validate_gateway
    GATEWAYS.include?(@gateway)
  end
end
