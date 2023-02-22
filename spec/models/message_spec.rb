require 'rails_helper'

RSpec.describe Message do
  describe 'Associations' do
    it { is_expected.to belong_to(:room) }
    it { is_expected.to belong_to(:user) }
  end

  describe '#display_time' do
    let(:today)     { Date.current.strftime('%Y-%m-%d 09:00') }
    let!(:message)  { create(:message, created_at: Time.zone.parse(today)) }
    let!(:message2) { create(:message, created_at: Time.zone.parse('2023-02-20 10:00')) }
    let!(:message3) { create(:message, created_at: Time.zone.parse('2023-01-20 09:30')) }
    let!(:message4) { create(:message, created_at: Time.zone.parse('2022-12-30 12:00')) }

    it 'returns display time' do
      expect(message.display_time).to eq '09:00'
      expect(message2.display_time).to eq 'Monday 10:00'
      expect(message3.display_time).to eq '20 Jan 09:30'
      expect(message4.display_time).to eq '30 Dec 2022 12:00'
    end
  end
end
