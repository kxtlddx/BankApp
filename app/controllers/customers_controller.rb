class CustomersController < ApplicationController
  before_action :authenticate_user!

  def show
    @customer = current_user
    authorize! @customer, with: CustomerPolicy
    @telecom_companies = TelecomCompany.all
  end

end
