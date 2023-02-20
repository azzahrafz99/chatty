require 'rails_helper'

RSpec.describe MessagesController do
  describe 'POST create' do
    let!(:user) { create(:user) }
    let!(:room) { create(:room) }

    let(:params) do
      {
        room_id: room.id,
        message: { body: 'Hello' }
      }
    end

    let(:last_message) { Message.last }

    context 'when user sign in' do
      before do
        sign_in(user)

        post :create, params: params
      end

      it 'creates message' do
        expect(last_message.user).to eq user
        expect(last_message.room).to eq room
        expect(last_message.body).to eq 'Hello'
      end
    end

    context 'when user not sign in' do
      before { post :create, params: params }

      it_behaves_like 'redirect to home with error message'
    end
  end
end
