require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:reason)}
    it {should validate_presence_of(:start_date)}
    it {should validate_presence_of(:salary)}
  end
end