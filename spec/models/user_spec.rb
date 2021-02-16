require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association' do
    it {should belong_to(:company).class_name('Company')}
  end

  describe 'validations' do
    subject {
      company = Company.new(name: 'Muzak', address: 'Santana',
                                cnpj: '12.345.678/0001-90', site: 'www.muzak.com.br')
      employee = User.new(email: 'murilo@muzak', password: '123456',
                              company: company)
    }

    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_uniqueness_of(:email).case_insensitive}
  end
end
