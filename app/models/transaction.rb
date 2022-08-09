class Transaction < ApplicationRecord
  enum transaction_type: {
    credit: 0,
    debit: 1
  }

  enum status: {
    initiated: 0,
    pending: 1,
    success: 2,
    failed: 3
  }

  belongs_to :account
  belongs_to :receiver, class_name: 'Account', foreign_key: 'receiver_id' # Considering transfer within app only

  before_create :assign_reference_no

  validates :amount, numericality: { greater_than: 0 }
  validates :reference_number, uniqueness: { case_sensitive: false }

  private

  def assign_reference_no
    self.reference_number = "#{rand.to_s[2..11]}-#{DateTime.now.to_i}"
  end
end
