class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:update]

  # POST /transactions
  def create
    redirect_to root_path unless current_user.customer?
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user
    @transaction.status = :pending

    authorize! @transaction


    if @transaction.save
      Rails.logger.error "amogus"

      TransactionFailureJob.set(wait: 30.seconds).perform_later(@transaction)
      redirect_to customer_path(current_user.id), notice: 'Transaction was successfully created.'
    else
      Rails.logger.error @transaction.errors.full_messages.join("\n")
      redirect_back(fallback_location: customer_path)
    end
  end

  # PATCH/PUT /transactions/1
  def update
    authorize! @transaction

    redirect_to root_path unless current_user.customer?
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: 'Transaction was successfully updated.'
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def cancel
    authorize! @transaction

    @transaction = Transaction.find(params[:id])

    if @transaction.pending?
      @transaction.update(status: :failed)
      flash[:notice] = 'Transaction was successfully cancelled.'
    else
      flash[:alert] = 'Only pending transactions can be cancelled.'
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:user_id, :telecom_company_id, :amount)
  end

end