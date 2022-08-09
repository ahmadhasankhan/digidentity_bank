require 'rails_helper'
require 'byebug'

RSpec.describe Transaction, type: :model do
  let(:user) { create(:user) }
  let(:receiver) { create(:user) }
  subject { described_class.new(account: user.accounts.first, receiver: receiver.accounts.first, amount: 10) }

  describe 'associations' do
    it { should belong_to(:account) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a receiver' do
      subject.receiver = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an amount' do
      subject.amount = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with negative amount' do
      subject.amount = -100
      expect(subject).to_not be_valid
    end

    it 'checks for reference number uniqueness' do
      subject.save
      account2 = create(:user).accounts.first
      new_transaction = Transaction.create(account: account2, receiver: receiver.accounts.first, amount: 10)

      expect { new_transaction.update!(reference_number: subject.reference_number) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Reference number has already been taken')
    end
  end
end
