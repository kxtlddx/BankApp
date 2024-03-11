class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:update]

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user

    if @transaction.save
      TransactionFailureJob.set(wait: 5.seconds).perform_later(@transaction)
      redirect_to @transaction, notice: 'Transaction was successfully created.'
    else
      @transaction.status = :failed
      redirect_back(fallback_location: root_path)
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: 'Transaction was successfully updated.'
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def cancel
    @transaction = Transaction.find(params[:id])

    if @transaction.pending?
      @transaction.update(status: :failed)
      flash[:notice] = 'Transaction was successfully cancelled.'
    else
      flash[:alert] = 'Only pending transactions can be cancelled.'
    end

    redirect_back(fallback_location: root_path)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:telecom_company_id, :amount)
  end

end