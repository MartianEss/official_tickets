class CustomerServices::ApplicationController < ApplicationController
  before_action :authenticate_customer_service!

  layout 'customer_services'

  before_action :find_customer_service, if: :current_customer_service

  private

  def find_customer_service
    @customer_service = current_customer_service
  end
end
