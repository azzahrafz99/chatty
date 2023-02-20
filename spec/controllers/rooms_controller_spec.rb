require 'rails_helper'

RSpec.describe RoomsController do
  let!(:user)  { create(:user) }
  let!(:user2) { create(:user) }
  let!(:room)  { create(:room) }

  describe 'GET index' do
    context 'when user sign in' do
      before do
        sign_in(user)

        get :index
      end

      it 'assigns instance variables' do
        expect(assigns(:rooms)).to eq [room]
        expect(assigns(:users)).to eq [user2]
      end
    end

    context 'when user not sign in' do
      before { get :index }

      it_behaves_like 'redirect to home with error message'
    end
  end

  describe 'GET show' do
    context 'when user sign in' do
      before do
        sign_in(user)

        get :show, params: { id: room.id }
      end

      it 'assigns instance variables' do
        expect(assigns(:single_room)).to eq room
        expect(assigns(:rooms)).to eq [room]
        expect(assigns(:users)).to eq [user2]
      end
    end

    context 'when user not sign in' do
      before { get :show, params: { id: room.id } }

      it_behaves_like 'redirect to home with error message'
    end
  end

  describe 'POST create' do
    let(:params) do
      { room: { name: 'General' } }
    end

    let(:last_room) { Room.last }

    context 'when user sign in' do
      before do
        sign_in(user)

        post :create, params: params
      end

      it 'creates room' do
        expect(last_room.name).to eq 'General'
      end
    end

    context 'when user not sign in' do
      before do
        post :create, params: params
      end

      it_behaves_like 'redirect to home with error message'
    end
  end
end
