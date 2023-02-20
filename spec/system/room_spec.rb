require 'rails_helper'

RSpec.describe 'Room' do
  let!(:user) { create(:user) }

  context 'when user create new public room' do
    before do
      sign_in_user(user)
      click_on 'Rooms'
      fill_in 'room_name', with: 'General'
      click_on 'Create Room'
    end

    it 'shows new room on side panel' do
      within('#rooms') do
        expect(all('.room').count).to eq 1
        expect(page).to have_text 'General'
      end
    end

    context 'when user send message' do
      before do
        within('#rooms') do
          click_on 'General'
        end

        fill_in 'message[body]', with: 'Hello'
        click_on 'Send'
      end

      it 'shows message' do
        within('#messages') do
          expect(page).to have_text user.email
          expect(page).to have_text 'Hello'
        end
      end
    end
  end

  context 'when user create new private room' do
    let!(:user2) { create(:user, email: 'john@sample.com ') }

    before do
      sign_in_user(user)
      click_on 'Rooms'
      click_on user2.email
    end

    it 'renders private room' do
      within('#single_room > .header') do
        expect(page).to have_text user2.email
      end
    end

    context 'when user send message' do
      before do
        fill_in 'message[body]', with: 'Hello'
        click_on 'Send'
      end

      it 'shows message' do
        within('#messages') do
          expect(page).to have_text 'Hello'
        end
      end
    end
  end
end
