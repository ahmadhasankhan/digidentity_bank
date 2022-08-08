module TransactionsHelper
  def find_transaction_type(transaction)
    if current_user.id == transaction.receiver_id
      'Credit'
    else
      transaction.transaction_type
    end
  end
end
