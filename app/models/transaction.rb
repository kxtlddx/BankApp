class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :telecom_company

  enum status: { pending: 1, completed: 2, failed: 3 }

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 50000 }
  validates :status, presence: true
end