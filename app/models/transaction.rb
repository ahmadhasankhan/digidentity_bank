class Transaction < ApplicationRecord
  enum status: {
    initiated: 0,
    pending: 1,
    success: 2,
    failed: 3
  }

  enum transaction_type:{
    tax_payment: 0,
    registration: 1,
  }

  belongs_to :business

  before_create :assign_reference_no

  validates :amount, numericality: { greater_than: 0 }
  validates :reference_number, uniqueness: { case_sensitive: false }

  private

  def assign_reference_no
    self.reference_number = "CP#{rand(3)}#{DateTime.now.to_i}"
  end
end
