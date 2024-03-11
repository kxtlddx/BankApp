class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! current_user, with: AdminPolicy
    @customers = User.all.where(role: 'customer')
  end

end