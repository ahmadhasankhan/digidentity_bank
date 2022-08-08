class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :accounts, dependent: :destroy

  validates_presence_of :first_name, :last_name, :username, :email
  validates :username, :email, uniqueness: { case_sensitive: false }

  after_create :create_bank_account

  private

  def create_bank_account
    self.accounts.create!
  end
end
