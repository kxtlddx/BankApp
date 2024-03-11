class TransactionFailureJob < ApplicationJob
  queue_as :default

  def perform(transaction)
    if rand < 0.5
      transaction.update(status: :failed)
    else
        transaction.update(status: :completed)
    end
  end
end