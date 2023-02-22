require 'rails_helper'

RSpec.describe 'Message' do
  let!(:user)  { create(:user, email: 'john@sample.com') }
  let!(:user2) { create(:user, email: 'foo@sample.com') }

  context 'when user send message' do
    before do
      sign_in_user(user)
      click_on user2.email
      fill_in 'message[body]', with: 'Hello'
      click_on 'Send'
    end

    # rubocop:disable RSpec/ExampleLength
    it 'shows message' do
      within('#messages') do
        expect(page).to have_text 'Hello'
      end

      using_session('Foo') do
        sign_in_user(user2)
        click_on user.email
        expect(page).to have_css('.bg-warning', wait: 5)
        fill_in 'message[body]', with: 'Hi'
        click_on 'Send'

        within('#messages') do
          expect(page).to have_text 'Hello'
        end
      end
    end
    # rubocop:enable RSpec/ExampleLength
  end
end
