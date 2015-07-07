class CustomerServices::ApplicationController < ApplicationController
  before_action :authenticate_customer_service!
end

