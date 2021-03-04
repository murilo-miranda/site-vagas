class User < ApplicationRecord
  belongs_to :company, optional: true
  has_many :sign_jobs
  has_many :vacancies, through: :sign_jobs
  has_one :account

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :create_company
  after_save :create_account

  private

    def create_account
      Account.create!(user: self)
    end

    def create_company
      if self.email.include?('gmail') == false && self.email.include?('hotmail') == false
        user_domain = self.email.match /(?<=@)[^.]+(?=\.)/
        company = Company.find_by(name: user_domain.to_s)
        if company == nil
          comp = Company.create!(name: user_domain, cnpj: '00.000.000/0000-00',
                                site: 'www.adicionarsite.com.br')
          self.company_id = comp.id
        end
      end
    end
end
