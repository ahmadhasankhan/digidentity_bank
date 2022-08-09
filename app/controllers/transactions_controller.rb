class TransactionsController < ApplicationController
  before_action :set_account

  def index
    @transactions = Transaction.where(account_id: @account.id).or(Transaction.where(receiver_id: @account.id))
  end

  def new
    @transaction = @account.transactions.new
  end

  def create
    @transaction = @account.transactions.new(transaction_params)
    @transaction.transaction_type = :debit

    respond_to do |format|
      begin
        @transaction.receiver = Account.find_receiver_account(@transaction, transaction_params[:receiver_id])
        Account.transaction do
          Account.transfer(@transaction)
        end
        @transaction.status = :success
        @transaction.message = 'Transaction was successful'
        @transaction.save!
        format.html { redirect_to account_transactions_url(@account), notice: "Account transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      rescue ActiveRecord::RecordInvalid => e
        logger.error(e.message)
        format.html { render :new, status: :unprocessable_entity, alert: "Something went wrong" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_account
    @account = Account.find(params[:account_id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:receiver_id, :amount, :account_id)
  end
end
