class AccountsController < ApplicationController
  before_action :authenticate_user!

  def my_accounts
    @accounts = current_user.accounts
  end

  def show
    @account = current_user.accounts.find(params[:id])
  end
end
