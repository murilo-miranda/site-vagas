class Company < ApplicationRecord
  has_many :user
  has_many :vacancy
  has_one_attached :logo do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end

  validates :name, :cnpj, :site, presence: true
  validates :cnpj, :site, uniqueness: true
end
