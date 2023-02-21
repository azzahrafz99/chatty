require 'rails_helper'

RSpec.describe Room do
  describe 'Associations' do
    it { is_expected.to have_many(:messages) }
    it { is_expected.to have_many(:participants).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe '#participant?' do
    let!(:room)  { create(:room) }
    let!(:user)  { create(:user) }
    let!(:user2) { create(:user) }

    let!(:participant) do
      create(:participant, user: user, room: room)
    end

    it 'returns true if user exist' do
      expect(room).to be_participant(room, user)
    end

    it 'returns false if user does not exist' do
      expect(room).not_to be_participant(room, user2)
    end
  end
end
