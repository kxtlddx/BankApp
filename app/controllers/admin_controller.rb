class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    @customers = User.all.where(role: 'customer')
  end

  private

  def ensure_admin
    redirect_to root_path unless current_user.admin?
  end
end