require 'rails_helper'

RSpec.describe Participant do
  describe 'Associations' do
    it { is_expected.to belong_to(:room) }
    it { is_expected.to belong_to(:user) }
  end
end
