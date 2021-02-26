class User < ApplicationRecord
  belongs_to :company
  has_one :account

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_save :create_account

  private

    def create_account
      Account.create!(user: self)
    end
end
