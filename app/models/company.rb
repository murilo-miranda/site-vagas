class Company < ApplicationRecord
  has_many :user

  validates :name, :cnpj, :site, presence: true
  validates :cnpj, :site, uniqueness: true
end
