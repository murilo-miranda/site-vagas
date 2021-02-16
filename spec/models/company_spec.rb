require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:cnpj)}
    it {should validate_presence_of(:site)}
    it {should validate_uniqueness_of(:cnpj)}
    it {should validate_uniqueness_of(:site)}
  end
end
