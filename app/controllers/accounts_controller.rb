class AccountsController < ApplicationController
  before_action :authenticate_user!

  def my_accounts
    @accounts = current_user.accounts
  end

  def show
    @account = current_user.accounts.find(params[:id])
    @transactions = Transaction.where(account_id: @account.id).or(Transaction.where(receiver_id: @account.id))
  end
end
