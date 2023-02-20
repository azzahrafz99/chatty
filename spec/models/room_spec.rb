require 'rails_helper'

RSpec.describe Room do
  describe 'Associations' do
    it { is_expected.to have_many(:messages) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
