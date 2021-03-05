class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :vacancy

  enum status: {pending: 0, approved: 5, declined: 10}

  validates :reason, :start_date, :salary, presence: true
end
