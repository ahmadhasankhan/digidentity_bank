require 'rails_helper'
RSpec.describe Account, type: :model do
  let(:user) { create(:user) }

  subject { described_class.new(user: user) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with negative balance' do
      subject.balance = -100
      expect(subject).to_not be_valid
    end

    it 'checks for account number uniqueness' do
      subject.save
      new_acc = Account.create(user: user)

      expect { new_acc.update!(account_number: subject.account_number) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Account number has already been taken')
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:transactions) }
  end

  describe '.assign_acc_number' do
    it 'assigns an account number' do
      subject.save
      expect(subject.account_number).not_to be_empty
    end
  end

  context 'money transfer' do
    let(:user2) { create(:user) }
    let(:transaction) { build(:transaction, account: subject, receiver: user2.accounts.first) }

    describe '#transfer' do
      it 'transfers the money' do
        transaction.amount = 101
        subject.balance = 200
        subject.save

        expect { Account.transfer(transaction) }.to change { user2.accounts.first.balance }.by(101)
      end
    end

    describe '.withdraw' do
      it 'withdraws money from the account' do
        transaction.amount = 100
        subject.balance = 200
        subject.save

        expect { subject.withdraw(transaction) }.to change { subject.balance }.by(-100)
      end

      it 'raises exception when insufficient balance' do
        transaction.amount = 1001
        subject.balance = 100
        subject.save

        expect { subject.withdraw(transaction) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Insufficient balance.')
      end
    end

    describe '.deposit' do
      it 'deposits the money to the beneficiary account' do
        transaction.amount = 100
        subject.balance = 99
        subject.save

        expect { subject.deposit(transaction) }.to change { subject.balance }.by(100)
      end
    end

    describe '#find_receiver_account' do
      it 'finds account using account number' do
        expect(Account.find_receiver_account(transaction, user2.accounts.first.account_number)).to eql(user2.accounts.first)
      end

      it 'throws exception when the account number is invalid' do
        expect { Account.find_receiver_account(transaction, Faker::Bank.iban) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Invalid Account Number.')
      end
    end
  end
end
