require 'rails_helper'

RSpec.describe Vacancy, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:job_title)}
    it {should validate_presence_of(:expiration_date)}
    it {should validate_presence_of(:max_vacancies)}
  end
end