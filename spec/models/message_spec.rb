require 'rails_helper'

RSpec.describe Message do
  describe 'Associations' do
    it { is_expected.to belong_to(:room) }
    it { is_expected.to belong_to(:user) }
  end

  describe '#display_time' do
    let(:today) { Date.current.strftime('%Y-%m-%d 09:00') }

    let!(:message) do
      create(:message, body: 'Hi', created_at: Time.zone.parse(today))
    end

    let!(:message2) do
      create(:message, body: 'Hello', created_at: Time.zone.parse('2023-02-20 10:00'))
    end

    it 'returns display time' do
      expect(message.display_time).to eq '09:00'
      expect(message2.display_time).to eq 'Monday 10:00'
    end
  end
end
