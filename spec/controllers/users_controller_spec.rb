require 'rails_helper'

RSpec.describe UsersController do
  let!(:user)  { create(:user) }
  let!(:user2) { create(:user) }

  describe 'GET direct_message' do
    let(:private_room) do
      Room.where(name: "private_#{user.id}_#{user2.id}").first
    end

    context 'when user sign in' do
      before do
        sign_in(user)

        get :direct_message, params: { id: user2.id }
      end

      it 'assigns instance variables' do
        expect(assigns(:messages)).to be_empty
        expect(assigns(:single_room)).to eq private_room
        expect(assigns(:user)).to eq user2
      end
    end

    context 'when user not sign in' do
      before { get :direct_message, params: { id: user2.id } }

      it_behaves_like 'redirect to home with error message'
    end
  end
end
