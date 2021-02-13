class Company < ApplicationRecord
  validates :name, :cnpj, :site, presence: true
  validates :cnpj, :site, uniqueness: true
end
