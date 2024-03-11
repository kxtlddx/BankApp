class TransactionPolicy < ApplicationPolicy
  def create?
    user.customer?
  end

  def update?
    user.customer?
  end

  def cancel?
    user.admin?
  end
end