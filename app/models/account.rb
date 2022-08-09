class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  before_validation :assign_acc_number, on: :create

  validates :account_number, :account_type, presence: true
  validates :balance, numericality: { greater_than: -1 }
  validates :account_number, uniqueness: { case_sensitive: false }

  enum account_type: {
    saving: 0,
    current: 1
  }

  def withdraw(transaction)
    if transaction.amount <= transaction.account.balance
      self.update!(balance: self.balance - transaction.amount)
    else
      transaction.errors.add(:base, "Insufficient balance.")
      raise ActiveRecord::RecordInvalid.new(transaction)
    end
  end

  def deposit(transaction)
    self.update!(balance: self.balance + transaction.amount)
  end

  def self.transfer(transaction)
    transaction.account.withdraw(transaction)
    transaction.receiver.deposit(transaction)
  end

  def self.find_receiver_account(transaction, receiver_no)
    acc = Account.find_by(account_number: receiver_no)
    return acc if acc && acc.id != transaction.account_id

    transaction.errors.add(:base, "Invalid Account Number.")
    raise ActiveRecord::RecordInvalid.new(transaction)
  end

  private

  def assign_acc_number
    acc_no = generate_account_no

    while Account.where(account_number: acc_no).any?
      acc_no = generate_account_no
    end

    self.account_number = acc_no
  end

  def generate_account_no
    "UN-01-DIGI-#{rand.to_s[2..11]}"
  end
end
