require "rails_helper"

feature "admin views events" do
  scenario "all in one list" do
    admin = signed_in_admin

    user_a = create(:user, name: 'Naseem Hamed')
    user_b = create(:user, name: 'Rodger Moore')

    create(:event, user: user_a, action: 'created tweet', meta: {message: 'hi there'})
    create(:event, user: user_b, action: 'liked movie', meta: {title: 'The Avengers'})

    visit hightower.root_path
    
    click_link t('hightower.nav.events_link')

    within('.main') do
      expect(page).to have_content user_a.name
      expect(page).to have_content 'created tweet'
      expect(page).to have_content 'message'
      expect(page).to have_content 'hi there'

      expect(page).to have_content user_b.name
      expect(page).to have_content 'liked movie'
      expect(page).to have_content 'title'
      expect(page).to have_content 'The Avengers'
    end
  end
end
