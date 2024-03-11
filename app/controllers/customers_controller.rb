class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_customer

  def show
    @customer = current_user
    @telecom_companies = TelecomCompany.all
  end

  private

  def ensure_customer
    redirect_to root_path unless current_user.customer?
  end
end
